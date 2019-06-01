#ifndef RESOURCE_H_
#define RESOURCE_H_

#include <stdint.h>

extern const uint16_t plane[48 * 75];
extern const uint16_t plane2[48 * 33];
extern const uint16_t background[640 * 480];

typedef struct {
	const uint16_t width;
	const uint16_t height;
	const uint16_t* data;
} sprite_data_t;

extern const sprite_data_t planes[];

#endif
