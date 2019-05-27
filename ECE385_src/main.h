#ifndef MAIN_H_
#define MAIN_H_

#define PLAYER_PLANE_HP 18
#define PLAYER_PLANE_ACCELERATION 16
#define PLAYER_PLANE_DEACCELERATION 8
#define PLAYER_PLANE_SPEED_MAX 96

#define PLAYER_BULLET_INTERVAL 20
#define PLAYER_BULLET_VX 4
#define PLAYER_BULLET_VY 8
#define PLAYER_BULLET_AX 1
#define PLAYER_BULLET_AY 4

#define ENEMY_PLANE_SPAWN_INTERVAL_MIN 20
#define ENEMY_PLANE_SPAWN_INTERVAL_MAX 60
#define ENEMY_PLANE_HP 2
#define ENEMY_PLANE_VX 64
#define ENEMY_PLANE_VY 64
#define ENEMY_PLANE_AX 1
#define ENEMY_PLANE_AY 1

#define ENEMY_BULLET_INTERVAL 33
#define ENEMY_BULLET_VX 0
#define ENEMY_BULLET_VY 0
#define ENEMY_BULLET_AX 0
#define ENEMY_BULLET_AY 1

#include "sprites.h"

extern volatile uint32_t frame_count;
extern volatile int* io_led_red;
extern volatile int* io_led_green;

void handle_player_plane_keyboard(int player_plane_id, volatile vga_sprite_info_t* player_plane_info);
void handle_enemy_planes_spawn();
void handle_enemy_planes_firing();
int main(void);

#endif /* MAIN_H_ */
