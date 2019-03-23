#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(hiredisccc,19.03)
AM_INIT_AUTOMAKE([1.9.5 foreign subdir-objects])

AC_CONFIG_SRCDIR([libhiredisccc/src/hircluster.c])

AM_CONDITIONAL([CYGWIN], [test `uname -o` = "Cygwin"])

LT_INIT([win32-dll])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stddef.h stdint.h event.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 docs/Makefile
                 examples/Makefile
                 libhiredisccc/Makefile])
AC_OUTPUT
