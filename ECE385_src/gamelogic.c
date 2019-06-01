#include "gamelogic.h"

#include <stdio.h>

#include "main.h"
#include "vga.h"
#include "resource.h"
#include "comm.h"
#include "rng.h"

volatile uint32_t frame_count = 0;

int player_plane_id = 0;
volatile vga_sprite_info_t* player_plane_info = NULL;

void game_init() {
	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, background);
	sprites_init(VGA_SPRITE_PLANE);
	sprites_init(VGA_SPRITE_BULLET);

//	printf("Wait for keyboard ready\n");
//	while(!keycode_comm->keyboard_present);
//	printf("Keyboard ready\n");

	// Create player's plane
	do {
		int id;
		int width = 75;
		int height = 48;
		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
			printf("ERR sprites_allocate");
			break;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane, width * height)) {
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
		sprite_info->type = 0;
		sprite_info->hp = PLAYER_PLANE_HP;
		sprite_info->vx = 0;
		sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
		sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->vy = 0;
		sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
		sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->ax = 0;
		sprite_info->ay = 0;
		sprite_info->physical->width = width;
		sprite_info->physical->height = height;

		// Set plane as player's plane
		player_plane_id = id;
		player_plane_info = sprite_info;
	} while(0);

	while(1) {
		while(*io_vga_sync == 0);	// Wait for VSync == 1

		while(*io_vga_sync == 1);	// Wait for VSync == 0
	}
}

void game_loop() {
	static int io_vga_sync_prev = 0;
	if(io_vga_sync_prev == 0 && *io_vga_sync == 1) {
		// New frame occured, do job
		frame_count++;

		handle_player_plane_keyboard(player_plane_id, player_plane_info);
		handle_enemy_planes_spawn();
		handle_enemy_planes_firing();

		// Sprites manager job
		sprites_tick(VGA_SPRITE_PLANE);
		sprites_tick(VGA_SPRITE_BULLET);
		sprites_collision_detect();

		// Lubenweiniubi
		player_plane_info->hp = PLAYER_PLANE_HP;

		// Update player HP
		*io_led_red = 0xffffffff << (PLAYER_PLANE_HP - player_plane_info->hp);
	}
	io_vga_sync_prev = *io_vga_sync;
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
//		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, plane2, width * height)) {
//			printf("ERR sprites_load_data");
//			return;
//		}
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
