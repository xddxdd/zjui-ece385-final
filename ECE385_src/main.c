#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#include "system.h"

#include "main.h"
#include "vga.h"
#include "resource.h"
#include "comm.h"
#include "rng.h"

#include "altera_avalon_sgdma.h"
#include "altera_avalon_sgdma_descriptor.h"
#include "altera_avalon_sgdma_regs.h"

#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"

volatile int* io_led_red = (int*) IO_LED_RED_BASE;
volatile int* io_led_green = (int*) IO_LED_GREEN_BASE;
volatile keycode_comm_t* keycode_comm = (keycode_comm_t*) USB_KEYCODE_BASE;
volatile int* io_hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;
volatile uint32_t frame_count = 0;
volatile int* io_hwrng = (int*) IO_HWRNG_BASE;
volatile int tmp;


// Function Prototypes
void eth0_rx_ethernet_isr (void *context);
void eth1_rx_ethernet_isr (void *context);

// Global Variables
unsigned int text_length;

// Create a transmit frame
unsigned char tx_frame[1024] = {
		0xFF,0xFF,0xFF,0xFF,0xFF,0xFF, 	// destination address (broadcast)
		0x01,0x60,0x6E,0x11,0x02,0x0F, 	// source address
		0x00,0x2E, 						// length or type of the payload data
		'H','e','l','l','o',' ','W','o','r','l','d','\n','\0', // payload data (ended with termination character)
};

// Create a receive frame
unsigned char eth0_rx_frame[1024] = { 0 };
unsigned char eth1_rx_frame[1024] = { 0 };

// Create sgdma transmit and receive devices
alt_sgdma_dev* eth0_dma_tx_dev;
alt_sgdma_dev* eth0_dma_rx_dev;
alt_sgdma_dev* eth1_dma_tx_dev;
alt_sgdma_dev* eth1_dma_rx_dev;

// Allocate descriptors in the descriptor_memory (onchip memory)
alt_sgdma_descriptor eth0_tx_descriptor;
alt_sgdma_descriptor eth0_tx_descriptor_end;

alt_sgdma_descriptor eth0_rx_descriptor;
alt_sgdma_descriptor eth0_rx_descriptor_end;

alt_sgdma_descriptor eth1_tx_descriptor;
alt_sgdma_descriptor eth1_tx_descriptor_end;

alt_sgdma_descriptor eth1_rx_descriptor;
alt_sgdma_descriptor eth1_rx_descriptor_end;


/********************************************************************************
 * This program demonstrates use of the Ethernet in the DE2-115 board.
 *
 * It performs the following:
 *  1. Records input text and transmits the text via Ethernet after Enter is
 *     pressed
 *  2. Displays text received via Ethernet frame on the JTAG UART
********************************************************************************/
int main(void)
{
	printf("Hello World\n");

	eth0_dma_tx_dev = alt_avalon_sgdma_open ("/dev/eth0_tx_dma");
	eth0_dma_rx_dev = alt_avalon_sgdma_open ("/dev/eth0_rx_dma");
	eth1_dma_tx_dev = alt_avalon_sgdma_open ("/dev/eth1_tx_dma");
	eth1_dma_rx_dev = alt_avalon_sgdma_open ("/dev/eth1_rx_dma");

	alt_avalon_sgdma_register_callback(eth0_dma_rx_dev, (alt_avalon_sgdma_callback) eth0_rx_ethernet_isr, 0x00000014, NULL );
	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth0_rx_descriptor, &eth0_rx_descriptor_end, (alt_u32 *)eth0_rx_frame, 0, 0 );
	alt_avalon_sgdma_do_async_transfer(eth0_dma_rx_dev, &eth0_rx_descriptor );

	alt_avalon_sgdma_register_callback(eth1_dma_rx_dev, (alt_avalon_sgdma_callback) eth1_rx_ethernet_isr, 0x00000014, NULL );
	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth1_rx_descriptor, &eth1_rx_descriptor_end, (alt_u32 *)eth1_rx_frame, 0, 0 );
	alt_avalon_sgdma_do_async_transfer(eth1_dma_rx_dev, &eth1_rx_descriptor );

	do {
		printf("Initializing eth0\n");
		volatile int* eth_mdio = ETH0_MDIO_BASE;
		eth_mdio[0x10] |= 0x0060;
		eth_mdio[0x14] |= 0x0082;
		eth_mdio[0x00] |= 0x8000;
		while(eth_mdio[0x00] & 0x8000);
	} while(0);

	do {
		printf("Initializing eth1\n");
		volatile int* eth_mdio = ETH1_MDIO_BASE;
		eth_mdio[0x10] |= 0x0060;
		eth_mdio[0x14] |= 0x0082;
		eth_mdio[0x00] |= 0x8000;
		while(eth_mdio[0x00] & 0x8000);
	} while(0);

	printf("Sending packets\n");
	while (1) {
		alt_avalon_sgdma_construct_mem_to_stream_desc(&eth0_tx_descriptor, &eth0_tx_descriptor_end, (alt_u32 *)tx_frame, 62, 0, 1, 1, 0 );
		alt_avalon_sgdma_do_sync_transfer(eth0_dma_tx_dev, &eth0_tx_descriptor);
		usleep(100000);
	}

	return 0;
}

/****************************************************************************************
 * Subroutine to read incoming Ethernet frames
****************************************************************************************/
void eth0_rx_ethernet_isr (void *context)
{
	// Wait until receive descriptor transfer is complete
	while (alt_avalon_sgdma_check_descriptor_status(&eth0_rx_descriptor)) {}

	// Output received text
	alt_printf( "eth0 recv> %s\n", eth0_rx_frame + 16 );

	// Create new receive sgdma descriptor
	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth0_rx_descriptor, &eth0_rx_descriptor_end, (alt_u32 *)eth0_rx_frame, 0, 0 );

	// Set up non-blocking transfer of sgdma receive descriptor
	alt_avalon_sgdma_do_async_transfer(eth0_dma_rx_dev, &eth0_rx_descriptor );
}

void eth1_rx_ethernet_isr (void *context)
{
	// Wait until receive descriptor transfer is complete
	while (alt_avalon_sgdma_check_descriptor_status(&eth1_rx_descriptor)) {}

	// Output received text
	alt_printf( "eth1 recv> %s\n", eth1_rx_frame + 16 );

	// Create new receive sgdma descriptor
	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth1_rx_descriptor, &eth1_rx_descriptor_end, (alt_u32 *)eth1_rx_frame, 0, 0 );

	// Set up non-blocking transfer of sgdma receive descriptor
	alt_avalon_sgdma_do_async_transfer(eth1_dma_rx_dev, &eth1_rx_descriptor );
}

//int main(void)
//{
//	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, background);
//	sprites_init(VGA_SPRITE_PLANE);
//	sprites_init(VGA_SPRITE_BULLET);
//
////	printf("Wait for keyboard ready\n");
////	while(!keycode_comm->keyboard_present);
////	printf("Keyboard ready\n");
//
//	int player_plane_id = 0;
//	volatile vga_sprite_info_t* player_plane_info = NULL;
//
//	// Create player's plane
//	do {
//		int id;
//		int width = 75;
//		int height = 48;
//		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
//			printf("ERR sprites_allocate");
//			break;
//		}
//		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane, width * height)) {
//			printf("ERR sprites_load_data");
//			break;
//		}
//		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
//		if(NULL == sprite_info) {
//			printf("ERR sprites_get");
//			break;
//		}
//		sprite_info->physical->x = (VGA_SPRITE_WIDTH - (75 << VGA_SPRITE_HW_SHIFT_BITS)) / 2;
//		sprite_info->physical->y = VGA_SPRITE_HEIGHT - (100 << VGA_SPRITE_HW_SHIFT_BITS);
//		sprite_info->type = 0;
//		sprite_info->hp = PLAYER_PLANE_HP;
//		sprite_info->vx = 0;
//		sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
//		sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
//		sprite_info->vy = 0;
//		sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
//		sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
//		sprite_info->ax = 0;
//		sprite_info->ay = 0;
//		sprite_info->physical->width = width;
//		sprite_info->physical->height = height;
//
//		// Set plane as player's plane
//		player_plane_id = id;
//		player_plane_info = sprite_info;
//	} while(0);
//
//	while(1) {
//		while(*io_vga_sync == 0);	// Wait for VSync == 1
//
//		frame_count++;
//
//		handle_player_plane_keyboard(player_plane_id, player_plane_info);
//		handle_enemy_planes_spawn();
//		handle_enemy_planes_firing();
//
//		// Sprites manager job
//		sprites_tick(VGA_SPRITE_PLANE);
//		sprites_tick(VGA_SPRITE_BULLET);
//		sprites_collision_detect();
//
//		// Lubenweiniubi
//		player_plane_info->hp = PLAYER_PLANE_HP;
//
//		// Update player HP
//		*io_led_red = 0xffffffff << (PLAYER_PLANE_HP - player_plane_info->hp);
//
//		while(*io_vga_sync == 1);	// Wait for VSync == 0
//	}
//
////	usleep(5000);
//
////	int* eth0_mdio = ETH0_MDIO_BASE;
////	int* eth1_mdio = ETH1_MDIO_BASE;
////
////	printf("Initializing eth0\n");
////	eth0_mdio[0x10] |= 0x0060;
////	eth0_mdio[0x14] |= 0x0082;
////	eth0_mdio[0x00] |= 0x8000;
////	while(eth0_mdio[0x00] & 0x8000);
////
////	printf("Initializing eth1\n");
////	eth1_mdio[0x10] |= 0x0060;
////	eth1_mdio[0x14] |= 0x0082;
////	eth1_mdio[0x00] |= 0x8000;
////	while(eth1_mdio[0x00] & 0x8000);
////
////	printf("Done\n");
//
//	return 0;
//}

void handle_player_plane_keyboard(int player_plane_id, volatile vga_sprite_info_t* player_plane_info) {
	uint8_t pressed_up = 0, pressed_left = 0, pressed_down = 0, pressed_right = 0;
	for(int i = 0; i < 2; i++) {
		int keycode = keycode_comm->keycode[i];
		if(i == 0) *io_hex = keycode;
		switch(keycode) {
		case 0x1A:	// W
		case 0x52:	// Up
			pressed_up = 1;
			break;
		case 0x04:	// A
		case 0x50:	// Left
			pressed_left = 1;
			break;
		case 0x16:	// S
		case 0x51:	// Down
			pressed_down = 1;
			break;
		case 0x07:	// D
		case 0x4F:	// Right
			pressed_right = 1;
			break;
		}
	}

	// Y input & resistance
	if(pressed_up && pressed_down) {
		// Player went crazy, do nothing
	} else if(pressed_up) {
		player_plane_info->vy -= PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vy < -PLAYER_PLANE_SPEED_MAX) player_plane_info->vy = -PLAYER_PLANE_SPEED_MAX;
	} else if(pressed_down) {
		player_plane_info->vy += PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vy > PLAYER_PLANE_SPEED_MAX) player_plane_info->vy = PLAYER_PLANE_SPEED_MAX;
	} else if(player_plane_info->vy > 0) {
		player_plane_info->vy -= PLAYER_PLANE_DEACCELERATION;
	} else if(player_plane_info->vy < 0) {
		player_plane_info->vy += PLAYER_PLANE_DEACCELERATION;
	}

	// X input & resistance
	if(pressed_left && pressed_right) {
		// Player went crazy, do nothing
	} else if(pressed_left) {
		player_plane_info->vx -= PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vx < -PLAYER_PLANE_SPEED_MAX) player_plane_info->vx = -PLAYER_PLANE_SPEED_MAX;
	} else if(pressed_right) {
		player_plane_info->vx += PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vx > PLAYER_PLANE_SPEED_MAX) player_plane_info->vx = PLAYER_PLANE_SPEED_MAX;
	} else if(player_plane_info->vx > 0) {
		player_plane_info->vx -= PLAYER_PLANE_DEACCELERATION;
	} else if(player_plane_info->vx< 0) {
		player_plane_info->vx += PLAYER_PLANE_DEACCELERATION;
	}

	// Prevent plane from flying out of screen
	sprites_limit_speed(VGA_SPRITE_PLANE, player_plane_id);

	if(frame_count % PLAYER_BULLET_INTERVAL == 0) {
		for(int i = 0; i < 3; i++) {
			int id;
			if(255 == (id = sprites_allocate(VGA_SPRITE_BULLET))) {
				printf("ERR sprites_allocate");
				break;
			}
			volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_BULLET, id);
			if(NULL == sprite_info) {
				printf("ERR sprites_get");
				break;
			}
			sprite_info->physical->x = player_plane_info->physical->x
					+ (player_plane_info->physical->width << VGA_SPRITE_HW_SHIFT_BITS) / 2;
			sprite_info->physical->y = player_plane_info->physical->y;
			sprite_info->physical->bullet_radius = 2;
			sprite_info->physical->bullet_color = 0x001f;
			sprite_info->type = 0;
			sprite_info->vx = PLAYER_BULLET_VX * (i - 1) + player_plane_info->vx;
			sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->vy = -PLAYER_BULLET_VY + player_plane_info->vy;
			sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->ax = PLAYER_BULLET_AX * (i - 1);
			sprite_info->ay = -PLAYER_BULLET_AY;
		};
	}
}

void handle_enemy_planes_spawn() {
	static int next_frame_count = 0;
	if(frame_count > next_frame_count) {
		int id;
		int width = 48;
		int height = 33;

		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
			printf("ERR sprites_allocate");
			return;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane2, width * height)) {
			printf("ERR sprites_load_data");
			return;
		}
		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
		if(NULL == sprite_info) {
			printf("ERR sprites_get");
			return;
		}

		int generate_pos = rng_generate() % (VGA_WIDTH + VGA_HEIGHT);
		if(generate_pos < VGA_HEIGHT / 2) {
			// Left top side of screen
			sprite_info->physical->x = ((-width) << VGA_SPRITE_HW_SHIFT_BITS) + 1;
			sprite_info->physical->y = generate_pos << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;

			sprite_info->vx = rng_generate() % ENEMY_PLANE_VX;
			if(sprite_info->ax < 0) {
				sprite_info->vx_min = ENEMY_PLANE_VX / 2;
			} else {
				sprite_info->vx_min = 0;
			}
			sprite_info->vx_max = ENEMY_PLANE_VX * 2;
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			if(generate_pos < VGA_HEIGHT / 4) {
				sprite_info->vy_min = 0;
			} else {
				sprite_info->vy_min = -ENEMY_PLANE_VY / 4;
			}
			sprite_info->vy_max = ENEMY_PLANE_VY * 2;
		} else if(generate_pos < VGA_HEIGHT) {
			// Right top side of screen
			sprite_info->physical->x = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->physical->y = (generate_pos - VGA_HEIGHT / 2) << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;

			sprite_info->vx = -(rng_generate() % ENEMY_PLANE_VX);
			sprite_info->vx_min = -ENEMY_PLANE_VX * 2;
			if(sprite_info->ax > 0) {
				sprite_info->vx_max = -ENEMY_PLANE_VX / 2;
			} else {
				sprite_info->vx_max = 0;
			}
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			if(generate_pos < VGA_HEIGHT * 3 / 4) {
				sprite_info->vy_min = 0;
			} else {
				sprite_info->vy_min = -ENEMY_PLANE_VY / 4;
			}
			sprite_info->vy_max = ENEMY_PLANE_VY * 2;
		} else {
			// Top side of screen
			sprite_info->physical->x = (generate_pos - VGA_HEIGHT) << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->physical->y = 0;
			sprite_info->vx = rng_generate() % (2 * ENEMY_PLANE_VX) - ENEMY_PLANE_VX;
			if(generate_pos - VGA_HEIGHT < VGA_WIDTH / 4) {
				sprite_info->vx_min = 0;
			} else {
				sprite_info->vx_min = -ENEMY_PLANE_VX;
			}
			if(generate_pos - VGA_HEIGHT > VGA_WIDTH * 3 / 4) {
				sprite_info->vx_max = 0;
			} else {
				sprite_info->vx_max = ENEMY_PLANE_VX;
			}
			sprite_info->vx_max = ENEMY_PLANE_VX;
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			sprite_info->vy_min = ENEMY_PLANE_VY / 2;
			sprite_info->vy_max = ENEMY_PLANE_VY * 4;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;
		}
		sprite_info->type = 1;
		sprite_info->hp = ENEMY_PLANE_HP;
//
//		sprite_info->vx = rng_generate() % (2 * ENEMY_PLANE_VX) - ENEMY_PLANE_VX;
//		sprite_info->vy = rng_generate() % (2 * ENEMY_PLANE_VY) - ENEMY_PLANE_VY;
//		sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
//		sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;

		sprite_info->physical->width = width;
		sprite_info->physical->height = height;

		next_frame_count = frame_count + ENEMY_PLANE_SPAWN_INTERVAL_MIN
				+ rng_generate() % (ENEMY_PLANE_SPAWN_INTERVAL_MAX - ENEMY_PLANE_SPAWN_INTERVAL_MIN);
	}
}

void handle_enemy_planes_firing() {
	vga_entity_manage_t* planes = VGA_SPRITE_PLANE;
	for(int i = 0; i < planes->max_size; i++) {
		volatile vga_sprite_info_t* plane_info = planes->info_arr + i;
		if(!plane_info->used) continue;
		if(plane_info->type != 1) continue;

//		if((frame_count - plane_info->frame_created) % ENEMY_BULLET_INTERVAL == 0) {
		if(frame_count % ENEMY_BULLET_INTERVAL == 0) {
			int id;
			if(255 == (id = sprites_allocate(VGA_SPRITE_BULLET))) {
				printf("ERR sprites_allocate");
				break;
			}
			volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_BULLET, id);
			if(NULL == sprite_info) {
				printf("ERR sprites_get");
				break;
			}
			sprite_info->physical->x = plane_info->physical->x
					+ (plane_info->physical->width << VGA_SPRITE_HW_SHIFT_BITS) / 2;
			sprite_info->physical->y = plane_info->physical->y
					+ (plane_info->physical->height << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->physical->bullet_radius = 2;
			sprite_info->physical->bullet_color = 0xf800;
			sprite_info->type = 1;
			sprite_info->vx = ENEMY_BULLET_VX;
			sprite_info->vy = ENEMY_BULLET_VY;
			sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->vy = ENEMY_BULLET_VY;
			sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->ax = ENEMY_BULLET_AX;
			sprite_info->ay = ENEMY_BULLET_AY;
		}
	}
}
