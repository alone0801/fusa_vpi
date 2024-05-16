
### Cross Compiler Configuration
CROSS_COMPILE?=or1k-elf-
CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar
RANLIB = $(CROSS_COMPILE)ranlib

### Configuration of drivers library output
LIB_OUTPUT = ./libdrivers/libdrivers.a
HEADER_DEST = ./libdrivers/include

### List of Basic Headers for driver build
INCLUDES_BASIC += ../board/generic_board
INCLUDES_BASIC += ../lib/include

### Drivers Files to be built in the libdrivers
# Find all .c files and include folders
CSRC = $(shell find . -name '*.c')
INCLUDES += $(shell find . -type d -name 'include')

### Setting Static Libraries required to build
LIBS += -lor1k

### Compilation directives
COBJ=$(CSRC:.c=.o)
OBJS=$(COBJ)

.PHONY: $(INCLUDES)

all: $(LIB_OUTPUT) $(INCLUDES) 

$(LIB_OUTPUT): $(OBJS)
	$(AR) cru $@ $^
	$(RANLIB) $@

$(COBJ): %.o: %.c
	$(CC) $(INCLUDES_BASIC:%=-I%) $(INCLUDES:%=-I%) $(LIBS) -c $< -o $@

$(INCLUDES):
	@mkdir -p $(HEADER_DEST)
	@install -C $@/*.h $(HEADER_DEST)

clean:
	@rm -rf libdrivers/*
	@rm -f ./*/*.o ./*/*.a ./*/*~
