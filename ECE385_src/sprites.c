#include "sprites.h"
#include "system.h"
#include "vga.h"

vga_sprite_info_t vga_planes_info[N_PLANES];
uint16_t* vga_planes_sprite_data[N_PLANES] = {
		(uint16_t*) VGA_SPRITE_0_BASE,
		(uint16_t*) VGA_SPRITE_1_BASE,
		(uint16_t*) VGA_SPRITE_2_BASE,
		(uint16_t*) VGA_SPRITE_3_BASE,
		(uint16_t*) VGA_SPRITE_4_BASE,
		(uint16_t*) VGA_SPRITE_5_BASE,
		(uint16_t*) VGA_SPRITE_6_BASE,
		(uint16_t*) VGA_SPRITE_7_BASE
};
vga_entity_manage_t vga_planes = {
		N_PLANES,
		vga_planes_sprite_data,
		(vga_entity_t*) VGA_SPRITE_PARAMS_BASE,
		vga_planes_info
};

vga_sprite_info_t vga_bullets_info[N_BULLETS];
vga_entity_manage_t vga_bullets = {
		N_BULLETS,
		(uint16_t**) NULL,
		((vga_entity_t*) VGA_SPRITE_PARAMS_BASE) + N_PLANES,
		vga_bullets_info
};

void sprites_init(vga_entity_manage_t* vga_entity_type) {
	for(int i = 0; i < vga_entity_type->max_size; i++) {
		vga_entity_type->info_arr[i].used = 0;
		vga_entity_type->info_arr[i].vx = 0;
		vga_entity_type->info_arr[i].vy = 0;
		vga_entity_type->info_arr[i].ax = 0;
		vga_entity_type->info_arr[i].ay = 0;
		vga_entity_type->info_arr[i].physical = vga_entity_type->mmap_addr + i;
		if(vga_entity_type->mmap_sprite_data) {
			vga_entity_type->info_arr[i].sprite_data = vga_entity_type->mmap_sprite_data[i];
		} else {
			vga_entity_type->info_arr[i].sprite_data = NULL;
		}
	}
}

// Return 0 for success, 255 for fail
uint8_t sprites_allocate(vga_entity_manage_t* vga_entity_type) {
	for(int i = 0; i < vga_entity_type->max_size; i++) {
		if(!vga_entity_type->info_arr[i].used) {
			vga_entity_type->info_arr[i].used = 1;
			vga_entity_type->info_arr[i].vx = 0;
			vga_entity_type->info_arr[i].vy = 0;
			vga_entity_type->info_arr[i].ax = 0;
			vga_entity_type->info_arr[i].ay = 0;
			vga_entity_type->info_arr[i].physical = vga_entity_type->mmap_addr + i;
			if(vga_entity_type->mmap_sprite_data) {
				vga_entity_type->info_arr[i].sprite_data = vga_entity_type->mmap_sprite_data[i];
			} else {
				vga_entity_type->info_arr[i].sprite_data = NULL;
			}
			return i;
		}
	}
	return 255;
}

// Return pointer to vga_sprite_info_t for success, NULL for fail
volatile vga_sprite_info_t* sprites_get(vga_entity_manage_t* vga_entity_type, uint8_t id) {
	if(id >= vga_entity_type->max_size) return NULL;
	if(!vga_entity_type->info_arr[id].used) return NULL;
	return vga_entity_type->info_arr + id;
}

// Return 0 for success, 255 for fail
uint8_t sprites_deallocate(vga_entity_manage_t* vga_entity_type, uint8_t id) {
	// Error checking
	if(id >= vga_entity_type->max_size) return 255;
	if(!vga_entity_type->info_arr[id].used) return 255;

	// Remove from screen
	vga_entity_type->info_arr[id].physical->x = 0;
	vga_entity_type->info_arr[id].physical->y = 0;
	vga_entity_type->info_arr[id].physical->width = 0;	// Alternatively, bullet_radius
	vga_entity_type->info_arr[id].physical->height = 0;	// Alternatively, bullet_color

	// Release entity
	vga_entity_type->info_arr[id].used = 0;
	return 0;
}

// Return 1 for visible, 0 for not
uint8_t sprites_visible(vga_entity_manage_t* vga_entity_type, uint8_t id) {
	// Error checking
	if(id >= vga_entity_type->max_size) return 0;
	if(!vga_entity_type->info_arr[id].used) return 0;

	if(vga_entity_type == VGA_SPRITE_PLANE) {
		// Plane x, y: left-top corner
		if(vga_entity_type->info_arr[id].physical->x >= VGA_WIDTH) return 0;
		if(vga_entity_type->info_arr[id].physical->y >= VGA_HEIGHT) return 0;

		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].physical->width
				< 0) {
			return 0;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].physical->height
				< 0) {
			return 0;
		}

		return 1;
	} else if(vga_entity_type == VGA_SPRITE_BULLET) {
		// Bullet x, y: center of bullet
		if(vga_entity_type->info_arr[id].physical->x - vga_entity_type->info_arr[id].physical->bullet_radius
				>= VGA_WIDTH) {
			return 0;
		}
		if(vga_entity_type->info_arr[id].physical->y - vga_entity_type->info_arr[id].physical->bullet_radius
				>= VGA_HEIGHT) {
			return 0;
		}

		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].physical->bullet_radius
				< 0) {
			return 0;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].physical->bullet_radius
				< 0) {
			return 0;
		}

		return 1;
	} else {
		return 0;
	}
}

uint8_t sprites_load_data(vga_entity_manage_t* vga_entity_type, uint8_t id, const uint16_t* src, int32_t pixel_count) {
	// Error checking
	if(id >= vga_entity_type->max_size) return 255;
	if(!vga_entity_type->info_arr[id].used) return 255;
	if(vga_entity_type->info_arr[id].sprite_data == NULL) return 255;

	volatile uint16_t* target = vga_entity_type->info_arr[id].sprite_data;
	// TODO: use faster methods, such as DMA?
	for(int i = 0; i < pixel_count; i++) {
		target[i] = src[i];
	}
	return 0;
}

uint8_t sprites_limit_speed(vga_entity_manage_t* vga_entity_type, uint8_t id) {
	// Error checking
	if(id >= vga_entity_type->max_size) return 255;
	if(!vga_entity_type->info_arr[id].used) return 255;

	if(vga_entity_type == VGA_SPRITE_PLANE) {
		// Plane x, y: left-top corner

		// Limit X
		if(vga_entity_type->info_arr[id].physical->x >= VGA_WIDTH) {
			vga_entity_type->info_arr[id].physical->x = VGA_WIDTH - 1;
		}
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].physical->width < 0) {
			vga_entity_type->info_arr[id].physical->x = -vga_entity_type->info_arr[id].physical->width;
		}

		// Limit VX
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].vx >= VGA_WIDTH) {
			vga_entity_type->info_arr[id].vx = VGA_WIDTH - vga_entity_type->info_arr[id].physical->x - 1;
		}
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].vx < 0) {
			vga_entity_type->info_arr[id].vx = - vga_entity_type->info_arr[id].physical->x;
		}

		// Limit Y
		if(vga_entity_type->info_arr[id].physical->y >= VGA_HEIGHT) {
			vga_entity_type->info_arr[id].physical->y = VGA_HEIGHT - 1;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].physical->height < 0) {
			vga_entity_type->info_arr[id].physical->y = -vga_entity_type->info_arr[id].physical->height;
		}

		// Limit VY
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].vy >= VGA_HEIGHT) {
			vga_entity_type->info_arr[id].vy = VGA_HEIGHT - vga_entity_type->info_arr[id].physical->y - 1;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].vy < 0) {
			vga_entity_type->info_arr[id].vy = - vga_entity_type->info_arr[id].physical->y;
		}
	} else if(vga_entity_type == VGA_SPRITE_BULLET) {
		// Bullet x, y: center of bullet

		// Limit X
		if(vga_entity_type->info_arr[id].physical->x - vga_entity_type->info_arr[id].physical->bullet_radius >= VGA_WIDTH) {
			vga_entity_type->info_arr[id].physical->x = VGA_WIDTH + vga_entity_type->info_arr[id].physical->bullet_radius - 1;
		}
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].physical->bullet_radius < 0) {
			vga_entity_type->info_arr[id].physical->x = -vga_entity_type->info_arr[id].physical->bullet_radius;
		}

		// Limit VX
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].vx
				- vga_entity_type->info_arr[id].physical->bullet_radius >= VGA_WIDTH) {
			vga_entity_type->info_arr[id].vx = VGA_WIDTH - vga_entity_type->info_arr[id].physical->x
					+ vga_entity_type->info_arr[id].physical->bullet_radius - 1;
		}
		if(vga_entity_type->info_arr[id].physical->x + vga_entity_type->info_arr[id].vx
				+ vga_entity_type->info_arr[id].physical->bullet_radius < 0) {
			vga_entity_type->info_arr[id].vx = - vga_entity_type->info_arr[id].physical->x
					- vga_entity_type->info_arr[id].physical->bullet_radius;
		}

		// Limit Y
		if(vga_entity_type->info_arr[id].physical->y - vga_entity_type->info_arr[id].physical->bullet_radius >= VGA_HEIGHT) {
			vga_entity_type->info_arr[id].physical->y = VGA_HEIGHT + vga_entity_type->info_arr[id].physical->bullet_radius - 1;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].physical->height < 0) {
			vga_entity_type->info_arr[id].physical->y = -vga_entity_type->info_arr[id].physical->bullet_radius;
		}

		// Limit VY
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].vy
				- vga_entity_type->info_arr[id].physical->bullet_radius >= VGA_HEIGHT) {
			vga_entity_type->info_arr[id].vy = VGA_HEIGHT - vga_entity_type->info_arr[id].physical->y
					+ vga_entity_type->info_arr[id].physical->bullet_radius - 1;
		}
		if(vga_entity_type->info_arr[id].physical->y + vga_entity_type->info_arr[id].vy
				+ vga_entity_type->info_arr[id].physical->bullet_radius < 0) {
			vga_entity_type->info_arr[id].vy = - vga_entity_type->info_arr[id].physical->y
					- vga_entity_type->info_arr[id].physical->bullet_radius;
		}
	}
	return 0;
}

// Return # of sprites processed
uint8_t sprites_tick(vga_entity_manage_t* vga_entity_type) {
	uint8_t processed = 0;
	for(int i = 0; i < vga_entity_type->max_size; i++) {
		if(!vga_entity_type->info_arr[i].used) continue;
		vga_entity_type->info_arr[i].physical->x += vga_entity_type->info_arr[i].vx;
		vga_entity_type->info_arr[i].physical->y += vga_entity_type->info_arr[i].vy;

		// If sprite fly off screen, deallocate immediately
		if(!sprites_visible(vga_entity_type, i)) {
			sprites_deallocate(vga_entity_type, i);
			continue;
		}

		vga_entity_type->info_arr[i].vx += vga_entity_type->info_arr[i].ax;
		vga_entity_type->info_arr[i].vy += vga_entity_type->info_arr[i].ay;
		processed++;
	}
	return processed;
}
