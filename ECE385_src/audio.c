#include "audio.h"
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer_regs.h"
#include <stdio.h>

#include "resources/sound_explosion.h"

//#include "memcpy_dma.h"

//#include "altera_avalon_sgdma.h"
//#include "altera_avalon_sgdma_descriptor.h"
//#include "altera_avalon_sgdma_regs.h"
//
//int audio_mem_next_half = 0;
//alt_sgdma_dev* audio_dma_dev = NULL;
//
//// Allocate descriptors in the descriptor_memory (onchip memory)
//alt_sgdma_descriptor audio_descriptor 		__attribute__((section(".onchip")));
//alt_sgdma_descriptor audio_descriptor_end 	__attribute__((section(".onchip")));

//void audio_send(uint8_t* src, int pos, int len) {
//	if(!audio_dma_dev) {
//		audio_dma_dev = alt_avalon_sgdma_open("/dev/audio_dma");
//	}
//	alt_avalon_sgdma_construct_mem_to_stream_desc(&audio_descriptor, &audio_descriptor_end, (alt_u32 *)src, len, 0, 1, 1, 0 );
//	alt_avalon_sgdma_do_async_transfer(audio_dma_dev, &audio_descriptor);
//}
//
//int audio_sending() {
//	return alt_avalon_sgdma_check_descriptor_status(&audio_descriptor);
//}

volatile uint32_t* audio_pio = (uint32_t*) AUDIO_PIO_BASE;
volatile uint32_t audio_pos = 0;
volatile uint32_t audio_len = 0;
volatile uint16_t* audio_src = NULL;
volatile int* audio_timer_ptr = (int*) AUDIO_TIMER_BASE;

volatile uint32_t explosion_pos = EXPLOSION_LEN / 2;
volatile uint16_t* explosion_src = (uint16_t*) explosion_data;

void audio_init() {
	IOWR_ALTERA_AVALON_TIMER_CONTROL(audio_timer_ptr,
			ALTERA_AVALON_TIMER_CONTROL_ITO_MSK | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
	);
	IOWR_ALTERA_AVALON_TIMER_STATUS(audio_timer_ptr, 0);
	alt_ic_isr_register(
			AUDIO_TIMER_IRQ_INTERRUPT_CONTROLLER_ID,
			AUDIO_TIMER_IRQ,
			audio_interrupt,
			(int*) audio_timer_ptr,
			NULL
	);
}

void audio_interrupt(void *context) {
	// ACK interrupt
	IOWR_ALTERA_AVALON_TIMER_STATUS(audio_timer_ptr, 0);

	if(!audio_src) return;
	if(++audio_pos >= audio_len) {
		audio_pos = 0;
	}
	uint16_t sound = audio_src[audio_pos];

	if(explosion_pos < EXPLOSION_LEN / 2) {
		uint16_t explosion_sound = explosion_src[explosion_pos++];
		*audio_pio = (((uint32_t) explosion_sound) << 16) | sound;
	} else {
		*audio_pio = (((uint32_t) sound) << 16) | sound;
	}

}
