#ifndef RESOURCE_H_
#define RESOURCE_H_

#include <stdint.h>

extern const uint16_t plane[48 * 32];
extern const uint16_t enemy0[48 * 32];
extern const uint16_t enemy1[48 * 32];
extern const uint16_t enemy2[48 * 32];
extern const uint16_t explosion0[32 * 32];
extern const uint16_t explosion1[32 * 32];
extern const uint16_t explosion2[32 * 32];
extern const uint16_t explosion3[32 * 32];
extern const uint16_t explosion4[32 * 32];
extern const uint16_t explosion5[32 * 32];
extern const uint16_t explosion6[32 * 32];
extern const uint16_t explosion7[32 * 32];
extern const uint16_t explosion8[32 * 32];
extern const uint16_t explosion9[32 * 32];
extern const uint16_t explosion10[32 * 32];
extern const uint16_t explosion11[32 * 32];
extern const uint16_t explosion12[32 * 32];
extern const uint16_t explosion13[32 * 32];
extern const uint16_t explosion14[32 * 32];
extern const uint16_t explosion15[32 * 32];
extern const uint16_t explosion16[32 * 32];
extern const uint16_t explosion17[32 * 32];
extern const uint16_t explosion18[32 * 32];
extern const uint16_t explosion19[32 * 32];
extern const uint16_t explosion20[32 * 32];
extern const uint16_t explosion21[32 * 32];
extern const uint16_t background[640 * 960];

typedef struct {
	const uint16_t width;
	const uint16_t height;
	const uint16_t* data;
} sprite_data_t;

extern const sprite_data_t planes[];
extern const uint16_t* explosion_sequence[];

#define ENEMY_RESOURCE_OFFSET 1
#define ENEMY_RESOURCE_NUM 3

#endif
