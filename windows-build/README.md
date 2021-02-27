# windows-build for SIMH

This repository contains the external dependencies needed to build full
asynchronous, networking and video support for the simh simulators on Windows.

It contains four separate packages which the windows simh build depends on:
    The WinPcap developer Pack
    Posix threads for Windows
    Simple DirectMedia Layer
    Perl Compatible Regular Expressions

The Visual Studio Projects in the simh source tree presume that 
The directory containing this file should be located parallel to the
directory containing the simh source code.  The makefile which can
be used by MinGW compiler also presumes the same directory structure.

For Example, the directory structure should look like:

    .../simh/simhv38-2-rc1/VAX/vax_cpu.c
    .../simh/simhv38-2-rc1/scp.c
    .../simh/simhv38-2-rc1/Visual Studio Projects/simh.sln
    .../simh/simhv38-2-rc1/Visual Studio Projects/VAX.vcproj
    .../simh/simhv38-2-rc1/BIN/Nt/Win32-Release/vax.exe
    .../simh/windows-build/pthreads/pthread.h
    .../simh/windows-build/winpcap/WpdPack/Include/pcap.h
    .../simh/windows-build/libSDL/SDL-2.0.0/include/SDL.h
    .../simh/windows-build/PCRE/include/pcreposix.h

The ../simh/windows-build/winpcap directory contains Version 4.1.2 of 
the winpcap developer pack from:

       http://www.winpcap.org/devel.htm

The ../simh/windows-build/pthreads directory contains the source to the 
next release of the pthreads-win32 Posix Threads package for the windows 
platform.

The ../simh/windows-build/libSDL directory contains the source to version
2.0.0 of libSDL2.  This source has been modified from the code in the zip
file: http://www.libsdl.org/release/SDL2-2.0.0.zip.  The modifications
produce SDL libraries which can be statically linked into simh simulator
binaries when building with the Microsoft Visual Studio compilers.  These 
binaries will then run without external DLL dependencies.  The MinGW link
libraries are also provided.  These have been extracted from:
http://www.libsdl.org/release/SDL2-devel-2.0.0-mingw.tar.gz along with
the SDL2.dll file which is required when running a simulator with video 
support if it is compiled with the MinGW gcc compiler.

The ../simh/windows-build/PCRE directory contains the source to PCRE version
8.36 the Perl Compatible Regular Expression library.

