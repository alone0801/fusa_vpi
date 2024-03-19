#
# Makefile for vpiDebug PLI functions
#

CFLAGS = -g

OBJS   = vpiDebug.o dumpHier.o dumpUpstream.o causalTree.o vcdCompare.o extractMod.o \
         traceSignal.o oscDetect.o eventTree.o hierTrace.o backTrace.o evCallback.o  \
         eosCallback.o vcdReader.o hash.o util.o

all:		libvpiDebug.a

libvpiDebug.a:	${OBJS} Makefile
		ar r $@ $^

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
vcdCompare.o:	vpiDebug.h vcdCompare.c
vcsReader.o:               vcdReader.c
vpiDebug.o:	vpiDebug.h vpiDebug.c
