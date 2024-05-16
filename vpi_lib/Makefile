#
# Makefile for vpiDebug PLI functions
#

CFLAGS = -g  -I /home/synopsys/vcs/O-2018.09-SP2/include -m64 -lxml2
LDFLAGS = -shared  -fPIC -m64
CC = gcc
OBJS   = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o vcdCompare.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_injector.o port_alias.o random.o 
SHARE_OBJS = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o sharevcd.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_injector.o port_alias.o random.o 
all:		libvpiDebug.so libsharefusa.so
share:      libvpiDebug.so
libvpiDebug.so: 	${OBJS} 
		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

libsharefusa.so: ${SHARE_OBJS}
		$(CC) $(CFLAGS) $(LDFLAGS) -D SHARE_LIB -o $@ $^

#libvpiDebug.a:	${OBJS} Makefile
#		ar r $@ $^

backTrace.o:	vpiDebug.h backTrace.c
causalTree.o:	vpiDebug.h causalTree.c
dumpHier.o:	vpiDebug.h dumpHier.c
dumpUpstream.o:	vpiDebug.h dumpUpstream.c
eosCallback.o:	vpiDebug.h eosCallback.c
evCallback.o:	vpiDebug.h evCallback.c
eventTree.o:	vpiDebug.h eventTree.c
extractMod.o:	vpiDebug.h extractMod.c
hash.o:		hash.h     hash.c
hierTrace.o:	vpiDebug.h hierTrace.c
oscDetect.o:	vpiDebug.h oscDetect.c
traceSignal.o:	vpiDebug.h traceSignal.c
util.o:                    util.c
vcdCompare.o:	vpiDebug.h vcdCompare.c StringList.h StringList.c
vcdReader.o:               vcdReader.c
vpiDebug.o:	vpiDebug.h vpiDebug.c
fault_injector.o: fault_injector.c fault_injector.h
StringList.o: StringList.c StringList.h
port_alias.o: port_alias.c
random.o: random.c random.h
sharevcd.o:  vcdCompare.c vpiDebug.h
	$(CC) $(CFLAGS) -D SHARE_LIB -c -fPIC $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

clean:
	rm -f *.o *.so
