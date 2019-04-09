
AM_CPPFLAGS = -O2 -g -I./include
AM_LDFLAGS =

AUTOMAKE_OPTIONS=foreign

INC1 = include/adapters/ae.h \
       include/adapters/glib.h \
       include/adapters/libev.h \
       include/adapters/libevent.h \
       include/adapters/libuv.h

INC2 = include/adlist.h \
       include/async.h \
       include/command.h \
       include/dict.h \
       include/fmacros.h \
       include/hiarray.h \
       include/hircluster.h \
       include/hiredis.h \
       include/hiredis_exports.h \
       include/hiutil.h \
       include/net.h \
       include/read.h \
       include/sds.h

SRC = src/adlist.c \
	    src/async.c \
      src/command.c \
	    src/crc16.c \
      src/dict.c \
	    src/hiarray.c \
      src/hircluster.c \
	    src/hiredis.c \
	    src/hiutil.c \
      src/net.c \
	    src/read.c \
      src/sds.c

lib_LTLIBRARIES = libhiredisccc.la
libhiredisccc_la_SOURCES = $(SRC)
libhiredisccc_la_LDFLAGS = -version-info 1:0:0
libhiredisccc_la_AR = $(AR) -qcs

oneincludedir = $(prefix)/include/hiredisccc/adapters
oneinclude_HEADERS = $(INC1)

twoincludedir = $(prefix)/include/hiredisccc
twoinclude_HEADERS = $(INC2)
