#ifndef _BOARD_H_
#define _BOARD_H_

#define IN_CLK  	      50000000 // Hz

//
// Defines for each core (memory map base,interrupt line number, etc.)
//
#define RAM_BASE            0x00000000
#define RAM_BASE_LDST_HIGH  0x0100     
#define RAM_BASE_LDST_LOW   0x0000      
#define RAM_BASE_STACK_HIGH 0x0080      
#define RAM_BASE_STACK_LOW  0x0000      


#define UART0_BASE  	    0x90000000
#define UART0_IRQ                    2
#define UART0_BAUD_RATE 	115200


#define INTGEN_BASE         0xe1000000
#define INTGEN_IRQ                  19


// TODO: Definitions below are only listed to compile Driver Tests
// They shoudl be updated or removed according to correct SoC Configuration
#define SPI0_BASE           0xb0000000
#define SPI1
#define SPI1_IRQ    2
#define SPI2_IRQ    5

#define CFI_CTRL_BASE       0xb0000000
#define SDRAM_BASE            0x00000000

#define ETH0_BASE           0xb0000000
#define ETH0_IRQ            3
#define ETH_MACADDR0        0x00
#define ETH_MACADDR1        0x00
#define ETH_MACADDR2        0x00
#define ETH_MACADDR3        0x00
#define ETH_MACADDR4        0x00
#define ETH_MACADDR5        0x00

//
// tick timer period define
//
#define TICKS_PER_SEC   100


//
// UART driver configuration
// 
#define UART_NUM_CORES 1
#define UART_BASE_ADDRESSES_CSV	UART0_BASE
#define UART_BAUD_RATES_CSV UART0_BAUD_RATE


#endif
