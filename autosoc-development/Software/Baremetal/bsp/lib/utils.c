
#include "utils.h"

/* Print out a character via simulator */
void sim_putc(unsigned char c)
{
  asm("l.addi\tr3,%0,0": :"r" (c));
  asm("l.nop %0": :"K" (NOP_PUTC));
}

/* print long */
void report(unsigned long value)
{
  asm("l.addi\tr3,%0,0": :"r" (value));
  asm("l.nop %0": :"K" (NOP_REPORT));
}

/* Loops/exits simulation */
void exit (int i)
{
  asm("l.add r3,r0,%0": : "r" (i));
  asm("l.nop %0": :"K" (NOP_EXIT));
  while (1);
}


/* Enable user interrupts */
void
cpu_enable_user_interrupts(void)
{
  /* Enable interrupts in supervisor register */
  or1k_mtspr (SPR_SR, or1k_mfspr (SPR_SR) | SPR_SR_IEE);
}

/* Tick timer variable */
unsigned long timer_ticks;

/* Tick timer functions */
/* Enable tick timer and interrupt generation */
void 
cpu_enable_timer(void)
{
  or1k_mtspr(SPR_TTMR, SPR_TTMR_IE | SPR_TTMR_RT | ((IN_CLK/TICKS_PER_SEC) & 
					       SPR_TTMR_PERIOD));
  or1k_mtspr(SPR_SR, SPR_SR_TEE | or1k_mfspr(SPR_SR));

}

/* Disable tick timer and interrupt generation */
void 
cpu_disable_timer(void)
{
  // Disable timer: clear it all!
  or1k_mtspr (SPR_SR, or1k_mfspr (SPR_SR) & ~SPR_SR_TEE);
  or1k_mtspr(SPR_TTMR, 0);

}

/* Timer increment - called by interrupt routine */
void 
cpu_timer_tick(void)
{
  timer_ticks++;
  // Reset timer mode register to interrupt with same interval
  or1k_mtspr(SPR_TTMR, SPR_TTMR_IE | SPR_TTMR_RT | 
	((IN_CLK/TICKS_PER_SEC) & SPR_TTMR_PERIOD));
}

/* Reset tick counter */
void 
cpu_reset_timer_ticks(void)
{
  timer_ticks=0;
}

/* Get tick counter */
unsigned long 
cpu_get_timer_ticks(void)
{
  return timer_ticks;
}

/* Wait for 10ms, assumes CLK_HZ is 100, which it usually is.
   Will be slightly inaccurate!*/
void 
cpu_sleep_10ms(void)
{
  unsigned long ttcr = or1k_mfspr(SPR_TTCR) & SPR_TTCR_PERIOD;
  unsigned long first_time = cpu_get_timer_ticks();
  while (first_time == cpu_get_timer_ticks()); // Wait for tick to occur
  // Now wait until we're past the tick value we read before to know we've
  // gone at least enough
  while(ttcr > (or1k_mfspr(SPR_TTCR) & SPR_TTCR_PERIOD));

}
