### Compiler Configurations ###
CROSS_COMPILE?=or1k-elf-
CFLAGS?=-O2
AS = $(CROSS_COMPILE)as
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc

### List of Headers to be Included ###
INCLUDE_TARGET?=-Iboard/generic_board
INCLUDE_TARGET+=-Ilib/include
# Drivers Headers
INCLUDE_TARGET+=-Idrivers/libdrivers/include

### Configuration of BSP Static Libraries
LIB_DIR += -L./drivers/libdrivers
LIB_DIR += -L./lib
LIBS += -lsupport
LIBS += -ldrivers
LIBS += -lor1k

### Definition of Test File list ###
TEST_LIST?=tests/basic
CTESTS = $(shell cat $(TEST_LIST).tests | grep .c)
STESTS = $(shell cat $(TEST_LIST).tests | grep .S)
STARGETS = $(STESTS:%.S=$(BUILDDIR)/%)
CTARGETS = $(CTESTS:%.c=$(BUILDDIR)/%)

BUILDDIR=build

.PHONY: all clean lib drivers
all: lib drivers $(STARGETS) $(CTARGETS)

$(STARGETS): $(BUILDDIR)/%: %.S lib
	@mkdir -p $(dir $@)
	$(CC) -nostartfiles $(INCLUDE_TARGET) $(CFLAGS) -Llib $< -lsupport -o $@

$(CTARGETS): $(BUILDDIR)/%: %.c lib drivers
	@mkdir -p $(dir $@)
	$(CC) $(INCLUDE_TARGET) $(CFLAGS) $(LIB_DIR) $< $(LIBS) -o $@

lib:
	$(MAKE) --directory=$@

drivers:
	$(MAKE) --directory=$@

clean:
	make -C lib/ clean
	make -C drivers/ clean
	rm -rf $(BUILDDIR)
