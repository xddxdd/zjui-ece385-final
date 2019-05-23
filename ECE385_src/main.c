#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "system.h"

#include "main.h"
#include "vga.h"
#include "resource.h"
#include "comm.h"

volatile int* io_led_red = (int*) IO_LED_RED_BASE;
volatile int* io_led_green = (int*) IO_LED_GREEN_BASE;
volatile keycode_comm_t* keycode_comm = (keycode_comm_t*) USB_KEYCODE_BASE;
volatile int* io_hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;
volatile uint32_t frame_count = 0;

int main(void)
{
	vga_fill(0, 0, VGA_WIDTH, VGA_HEIGHT, 0xffff);
	sprites_init(VGA_SPRITE_PLANE);
	sprites_init(VGA_SPRITE_BULLET);

	int player_plane_id = 0;
	volatile vga_sprite_info_t* player_plane_info = NULL;

	// Create player's plane
	do {
		int id;
		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
			printf("ERR sprites_allocate");
			break;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane, 75 * 48)) {
			printf("ERR sprites_load_data");
			break;
		}
		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
		if(NULL == sprite_info) {
			printf("ERR sprites_get");
			break;
		}
		sprite_info->physical->x = (VGA_SPRITE_WIDTH - (75 << VGA_SPRITE_HW_SHIFT_BITS)) / 2;
		sprite_info->physical->y = VGA_SPRITE_HEIGHT - (100 << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->physical->width = 75;
		sprite_info->physical->height = 48;
		sprite_info->type = 0;
		sprite_info->hp = PLAYER_PLANE_HP;
		sprite_info->vx = 0;
		sprite_info->vy = 0;
		sprite_info->ax = 0;
		sprite_info->ay = 0;

		// Set plane as player's plane
		player_plane_id = id;
		player_plane_info = sprite_info;
	} while(0);

	while(1) {
		while(*io_vga_sync == 0);	// Wait for VSync == 1

		frame_count++;

		handle_player_plane_keyboard(player_plane_id, player_plane_info);
		handle_enemy_planes_spawn();
		handle_enemy_planes_firing();

		// Sprites manager job
		int processed_planes = sprites_tick(VGA_SPRITE_PLANE);
		int processed_bullets = sprites_tick(VGA_SPRITE_BULLET);
		int collided = sprites_collision_detect();
		printf("%d planes, %d bullets, %d collided\n", processed_planes, processed_bullets, collided);

		// Update player HP
		*io_led_red = 0xffffffff << (PLAYER_PLANE_HP - player_plane_info->hp);

		while(*io_vga_sync == 1);	// Wait for VSync == 0
	}

//	usleep(5000);

//	int* eth0_mdio = ETH0_MDIO_BASE;
//	int* eth1_mdio = ETH1_MDIO_BASE;
//
//	printf("Initializing eth0\n");
//	eth0_mdio[0x10] |= 0x0060;
//	eth0_mdio[0x14] |= 0x0082;
//	eth0_mdio[0x00] |= 0x8000;
//	while(eth0_mdio[0x00] & 0x8000);
//
//	printf("Initializing eth1\n");
//	eth1_mdio[0x10] |= 0x0060;
//	eth1_mdio[0x14] |= 0x0082;
//	eth1_mdio[0x00] |= 0x8000;
//	while(eth1_mdio[0x00] & 0x8000);
//
//	printf("Done\n");

	return 0;
}

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
			sprite_info->physical->bullet_radius = 3;
			sprite_info->physical->bullet_color = 0x001f;
			sprite_info->type = 0;
			sprite_info->vx = PLAYER_BULLET_VX * (i - 1) + player_plane_info->vx;
			sprite_info->vy = -PLAYER_BULLET_VY + player_plane_info->vy;
			sprite_info->ax = PLAYER_BULLET_AX * (i - 1);
			sprite_info->ay = -PLAYER_BULLET_AY;
		};
	}
}

void handle_enemy_planes_spawn() {
	if(frame_count % ENEMY_PLANE_SPAWN_INTERVAL == 0) {
		int id;
		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
			printf("ERR sprites_allocate");
			return;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane, 75 * 48)) {
			printf("ERR sprites_load_data");
			return;
		}
		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
		if(NULL == sprite_info) {
			printf("ERR sprites_get");
			return;
		}
		sprite_info->physical->x = ((-75) << VGA_SPRITE_HW_SHIFT_BITS) + 1;
		sprite_info->physical->y = 0;
		sprite_info->physical->width = 75;
		sprite_info->physical->height = 48;
		sprite_info->type = 1;
		sprite_info->hp = 3;
		sprite_info->vx = 160;
		sprite_info->vy = 0;
		sprite_info->ax = 0;
		sprite_info->ay = 2;
	}
}

void handle_enemy_planes_firing() {
	vga_entity_manage_t* planes = VGA_SPRITE_PLANE;
	int32_t collided = 0;
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
			sprite_info->physical->bullet_radius = 3;
			sprite_info->physical->bullet_color = 0xf800;
			sprite_info->type = 1;
			sprite_info->vx = ENEMY_BULLET_VX;
			sprite_info->vy = ENEMY_BULLET_VY;
			sprite_info->ax = ENEMY_BULLET_AX;
			sprite_info->ay = PLAYER_BULLET_AY;
		}
	}
}
