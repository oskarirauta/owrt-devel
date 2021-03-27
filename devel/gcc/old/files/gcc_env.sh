#!/bin/sh'
export LDFLAGS="ENV_LDFLAGS -Wl,-rpath=/usr/lib -Wl,--dynamic-linker=/usr/lib/$(DYNLINKER) -L/usr/lib, -lstdc++"
export CFLAGS=ENV_CFLAGS
