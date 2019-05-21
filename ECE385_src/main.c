#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "system.h"

#include "main.h"
#include "vga.h"
#include "resource.h"
#include "comm.h"
#include "sprites.h"

volatile keycode_comm_t* keycode_comm = (keycode_comm_t*) USB_KEYCODE_BASE;
volatile int* hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;

int main(void)
{
	printf("Hello World\n");

	vga_fill(0, 0, VGA_WIDTH, VGA_HEIGHT, 0xffff);

	sprites_init(VGA_SPRITE_PLANE);
	sprites_init(VGA_SPRITE_BULLET);

	int player_plane_id = 0;
	volatile vga_sprite_info_t* player_plane_info = NULL;

	// Create a plane
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
		sprite_info->physical->x = 400;
		sprite_info->physical->y = 300;
		sprite_info->physical->width = 75;
		sprite_info->physical->height = 48;
		sprite_info->vx = 0;
		sprite_info->vy = 0;
		sprite_info->ax = 0;
		sprite_info->ay = 0;

		// Set plane as player's plane
		player_plane_id = id;
		player_plane_info = sprite_info;
	} while(0);

	// Create a bullet
	do {
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
		sprite_info->physical->x = 200;
		sprite_info->physical->y = 200;
		sprite_info->physical->bullet_radius = 3;
		sprite_info->physical->bullet_color = 0x8888;
		sprite_info->vx = 1;
		sprite_info->vy = 1;
		sprite_info->ax = 0;
		sprite_info->ay = 0;
	} while(0);

	while(1) {
		while(*io_vga_sync == 0);	// Wait for VSync == 1

		do {	// user input job
			uint8_t pressed_up = 0, pressed_left = 0, pressed_down = 0, pressed_right = 0;
			for(int i = 0; i < 2; i++) {
				int keycode = keycode_comm->keycode[i];
				if(i == 0) *hex = keycode;
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
				player_plane_info->vy -= 3;
			} else if(pressed_down) {
				player_plane_info->vy += 3;
			} else if(player_plane_info->vy > 0) {
				player_plane_info->vy -= 1;
			} else if(player_plane_info->vy < 0) {
				player_plane_info->vy += 1;
			}

			// X input & resistance
			if(pressed_left && pressed_right) {
				// Player went crazy, do nothing
			} else if(pressed_left) {
				player_plane_info->vx -= 3;
			} else if(pressed_right) {
				player_plane_info->vx += 3;
			} else if(player_plane_info->vx > 0) {
				player_plane_info->vx -= 1;
			} else if(player_plane_info->vx< 0) {
				player_plane_info->vx += 1;
			}

			// Prevent plane from flying out of screen
			sprites_limit_speed(VGA_SPRITE_PLANE, player_plane_id);
		} while(0);

		// Sprites manager job
		sprites_tick(VGA_SPRITE_PLANE);
		sprites_tick(VGA_SPRITE_BULLET);

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
