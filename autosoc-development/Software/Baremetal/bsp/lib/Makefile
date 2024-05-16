CROSS_COMPILE?=or1k-elf-
CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar
RANLIB = $(CROSS_COMPILE)ranlib

INCLUDES = -Iinclude
INCLUDES += -I../board/generic_board

SSRC = 	cache.S \
	mmu.S 	\
	stack.S

CSRC = utils.c \
       int.c
SOBJ=$(SSRC:.S=.o)
COBJ=$(CSRC:.c=.o)
OBJS=$(COBJ) $(SOBJ)

all: libsupport.a

libsupport.a: $(OBJS)
	$(AR) cru $@ $^
	$(RANLIB) $@

$(SOBJ): %.o: %.S
	$(CC) $(INCLUDES) -c $< -o $@

$(COBJ): %.o: %.c
	$(CC) $(INCLUDES) -Lor1k -c $< -o $@

clean:
	rm -f *.o *.a *~
