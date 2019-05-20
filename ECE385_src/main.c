#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "system.h"

#include "vga.h"
#include "resource.h"
#include "comm.h"

typedef struct {
	alt_u32 x;
	alt_u32 y;
	union {
		// For airplane
		struct {
			alt_u32 width;
			alt_u32 height;
		};
		// For bullet
		struct {
			alt_u32 bullet_radius;
			alt_u32 bullet_color;
		};
	};
} vga_entity_t;

volatile vga_entity_t* vga_entities = (vga_entity_t*) VGA_SPRITE_PARAMS_BASE;

volatile keycode_comm_t* keycode_comm = (keycode_comm_t*) USB_KEYCODE_BASE;
volatile int* hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;

int main(void)
{
	printf("Hello World\n");

//	while(1) {
//		*hex = keycode_comm->keycode[0];
//	}

	vga_fill(0, 0, VGA_WIDTH, VGA_HEIGHT, 0xffff);

//	while(1) {
//		printf("Loop\n");
//		for(int x = 100; x < 500; x++) {
//			vga_set(x, 0, 75, 48, plane);
//			vga_fill(x, 0, 1, 48, 0xffff);
//		}
//	}

	for(int i = 0; i < 64; i++) {
		vga_entities[i].x = 0;
		vga_entities[i].y = 0;
		vga_entities[i].width = 0;
		vga_entities[i].height = 0;
	}

	vga_entities[0].x = 0;
	vga_entities[0].y = 0;
	vga_entities[0].width = 75;
	vga_entities[0].height = 48;

	vga_entities[8].x = 200;
	vga_entities[8].y = 200;
	vga_entities[8].bullet_radius = 3;
	vga_entities[8].bullet_color = 0x8888;

	for(int i = 0; i < 75*48; i++) {
		((uint16_t*) VGA_SPRITE_0_BASE)[i] = plane[i];
	}

	int y = 200;
	int x = 300;
	while(1) {
		// Wait for VSync == 1
		while(*io_vga_sync == 0);

		// Do actual job
		do {
			for(int i = 0; i < 2; i++) {
				int keycode = keycode_comm->keycode[i];
				if(i == 0) *hex = keycode;
				switch(keycode) {
				case 0x1A:	// W
				case 0x52:	// Up
					if(y > -48) y--;
					break;
				case 0x04:	// A
				case 0x50:	// Left
					if(x > -75) x--;
					break;
				case 0x16:	// S
				case 0x51:	// Down
					if(y < 480) y++;
					break;
				case 0x07:	// D
				case 0x4F:	// Right
					if(x < 640) x++;
					break;
				}
			}
			vga_entities[8].x = x;
			vga_entities[8].y = y;

			printf("%d %d %d %d\n", x, y, vga_entities[8].x, vga_entities[8].y);

		} while(0);

		// Wait for VSync == 0
		while(*io_vga_sync == 1);
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
