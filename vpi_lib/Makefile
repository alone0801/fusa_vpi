#
# Makefile for vpiDebug PLI functions
#

CFLAGS = -g  -I /home/cadence/INCISIVE152/tools.lnx86/inca/include -m64 -lxml2
LDFLAGS = -shared  -fPIC -m64
CC = gcc
OBJS   = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o vcdCompare.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_modeling.o fault_injector.o port_alias.o random.o  timeRecord.o iso.o meminit.o
SHARE_OBJS = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o sharevcd.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_modeling.o fault_injector.o port_alias.o random.o timeRecord.o iso.o  meminit.o
all:		libvpiDebug.so libsharefusa.so libvpiDebug_irun.so libsharefusa_irun.so
share:      libvpiDebug.so libvpiDebug_irun.so
libvpiDebug.so: 	${OBJS} 
		$(CC) $(CFLAGS) $(LDFLAGS) -g -o $@ $^

libsharefusa.so: ${SHARE_OBJS}
		$(CC) $(CFLAGS) $(LDFLAGS) -D SHARE_LIB -g -o $@ $^

OBJS_IRUN   = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o vcdCompare_irun.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_modeling.o fault_injector.o port_alias.o random.o  timeRecord.o iso.o meminit.o
SHARE_OBJS_IRUN = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o sharevcd_irun.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o  StringList.o fault_modeling.o fault_injector.o port_alias.o random.o timeRecord.o iso.o  meminit.o
libvpiDebug_irun.so: 	${OBJS_IRUN} 
		$(CC) $(CFLAGS) $(LDFLAGS) -g -o $@ $^

libsharefusa_irun.so: ${SHARE_OBJS_IRUN}
		$(CC) $(CFLAGS) $(LDFLAGS) -D SHARE_LIB -g -o $@ $^

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
vcdCompare.o:	vpiDebug.h vcdCompare.c StringList.h StringList.c meminit.h
vcdCompare_irun.o:	vpiDebug.h vcdCompare_irun.c StringList.h StringList.c meminit.h
timeRecord.o:   vpiDebug.h timeRecord.c
vcdReader.o:               vcdReader.c
vpiDebug.o:	vpiDebug.h vpiDebug.c
fault_injector.o: fault_injector.c fault_injector.h
fault_modeling.o:fault_modeling.c
StringList.o: StringList.c StringList.h
port_alias.o: port_alias.c
iso.o : iso.c iso.h
random.o: random.c random.h
meminit.o: meminit.c
sharevcd.o:  vcdCompare.c vpiDebug.h
	$(CC) $(CFLAGS) -D SHARE_LIB -c -fPIC $< -o $@
sharevcd_irun.o:  vcdCompare_irun.c vpiDebug.h
	$(CC) $(CFLAGS) -D SHARE_LIB -c -fPIC $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

clean:
	rm -f *.o *.so
