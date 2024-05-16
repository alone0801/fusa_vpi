
CFLAGS = -g  -I /home/synopsys/vcs/O-2018.09-SP2/include  -lxml2  -lelf -I /home/ICer/fusa_vpi/vpi_lib
#-m32
LDFLAGS = -shared  -fPIC -L/home/ICer/fusa_vpi/vpi_lib   -lsharefusa
CC = gcc
OBJS   = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o vcdCompare.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_injector.o port_alias.o random.o 

all:		elf-loader.so
share:      libvpiDebug.so
libvpiDebug.so: 	${OBJS} 
		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

libvpiDebug.a:	${OBJS} Makefile
		ar r $@ $^

#jtag_vpi.o: jtag_vpi.c
#jtag_vpi.so: jtag_vpi.o
#		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
vpi_user.o:vpi_user.c elf-loader.h
elf-loader.o:elf-loader.c  elf-loader.h 
elf-loader.so: elf-loader.o vpi_user.o ../jtag_vpi_0-r2/jtag_vpi.o	
		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
%.o: %.c
	$(CC) $(CFLAGS) -c -fPIC  $< -o $@

clean:
	rm -f *.o *.so
