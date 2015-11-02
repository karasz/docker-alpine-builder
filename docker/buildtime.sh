#!/bin/sh
cd /tmp
tar xzvf time-1.7.tar.gz
cd time-1.7
patch -p1 < ../001-fix-configure.patch
patch -p1 < ../002-fix-rusage.patch
autoreconf -vif
./configure --prefix=/usr
make && make install

