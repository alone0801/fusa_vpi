#ifndef _UTILS_H_
#define _UTILS_H_

#include <or1k-support.h>

// Pull in interrupt defines here
#include "board.h"
#include "int.h"

/*
 * l.nop constants
 *
 */
#define NOP_NOP          0x0000      /* Normal nop instruction */
#define NOP_EXIT         0x0001      /* End of simulation */
#define NOP_REPORT       0x0002      /* Simple report */
/*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
#define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
#define NOP_CNT_RESET    0x0005	     /* Reset statistics counters */
#define NOP_GET_TICKS    0x0006	     /* JPB: Get # ticks running */
#define NOP_GET_PS       0x0007      /* JPB: Get picosecs/cycle */
#define NOP_TRACE_ON     0x0008      /* Turn on tracing */
#define NOP_TRACE_OFF    0x0009      /* Turn off tracing */
#define NOP_RANDOM       0x000a      /* Return 4 random bytes */
#define NOP_OR1KSIM      0x000b      /* Return non-zero if this is Or1ksim */

/* Print out a character via simulator */
void sim_putc(unsigned char c);

/* Prints out a value */
void report(unsigned long value);

/* Loops/exits simulation */
void exit(int i);

/* Enable user interrupts */
void cpu_enable_user_interrupts(void);

/* Variable keeping track of timer ticks */
extern unsigned long timer_ticks;
/* Enable tick timer and interrupt generation */
void cpu_enable_timer(void);
/* Disable tick timer and interrupt generation */
void cpu_disable_timer(void);
/* Timer increment - called by interrupt routine */
void cpu_timer_tick(void);
/* Reset tick counter */
void cpu_reset_timer_ticks(void);
/* Get tick counter */
unsigned long cpu_get_timer_ticks(void);
/* Wait for 10ms */
void cpu_sleep_10ms(void);

#endif
