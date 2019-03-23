
AM_CPPFLAGS = -I../libhiredisccc/include

AM_LDFLAGS = -levent

#if CYGWIN
#LDADD = /lib/libevent_core.dll.a
#else
#AM_LDFLAGS = -levent -lhiredisccc
#endif

AUTOMAKE_OPTIONS=foreign
bin_PROGRAMS=test_async_cluster test_async_non_cluster test_sync

test_async_cluster_SOURCES=src/async-cluster.c
test_async_non_cluster_SOURCES=src/async-non-cluster.c
test_sync_SOURCES=src/sync.c

test_async_cluster_LDADD = $(top_builddir)/libhiredisccc/libhiredisccc.la
test_async_non_cluster_LDADD = $(top_builddir)/libhiredisccc/libhiredisccc.la
test_sync_LDADD = $(top_builddir)/libhiredisccc/libhiredisccc.la
