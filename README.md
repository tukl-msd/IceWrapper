##*The IceWrapper code was ported to inside the [3D-ICE](http://esl.epfl.ch/3D-ICE) project in order to make users' life easyer! Please use directly the latest version of 3D-ICE!*

You can [download 3D-ICE here](http://esl.epfl.ch/3d-ice/download.html). You will find on its user manual instructions on how to bind it to your SystemC/TLM2.0 application. An example code is also provided.

IceWrapper - A SystemC Wrapper for 3D-ICE
=========================================

This repository contains a wrapper for [3D-ICE](http://esl.epfl.ch/3D-ICE) (from EPFL) for SystemC based simulations. With this wrapper 3D-ICE can easily be integrated into any SystemC or TLM based simulation environment.


## Contact

Don't hesitate to contact us:
    [Matthias Jung](https://ems.eit.uni-kl.de/mitarbeiter/matthias-jung/) and [Éder F. Zulian](https://ems.eit.uni-kl.de/mitarbeiter/eder-ferreira-zulian/)

## LICENSE 
Copyright (c) 2015, University of Kaiserslautern
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Author: Matthias Jung

# Dependencies

    - 3D-ICE 2.2.5
        - bison 2.4.1
        - flex 2.5.35
        - gcc 4.1.2
        - SuperLU 4.3 (BLAS)
    - SystemC 2.3
    - qmake


# Basic Setup

Configure the paths to:

    - SuperLU 4.3
    - 3D-ICE 2.2.5
    - SystemC 2.3

in the 3D-ICE-SystemC-Client.pro file.

Optionally you can set environment variables in your ~/.bashrc file or equivalent.

```bash
# SuperLU library home
export LIBSUPERLU_HOME=<path>

# 3D-ICE libraby home
export LIBTHREED_ICE_HOME=<path>

# SystemC home and target architecture
export SYSTEMC_HOME=<path>
export SYSTEMC_TARGET_ARCH=<[linux,linux64]>
```

The file 3D-ICE-SystemC-Client.cpp shows an example implementation of a SystemC based simulator and how the IceWrapper can be used in it.

For project build run do qmake and make:

    $ qmake 3D-ICE-SystemC-Client.pro
    $ make

# Starting Simulation

## 1. Start 3D-ICE Simulation Server (More Information can be found in the [3D-ICE Handbook](http://esl.epfl.ch/files/content/sites/esl/files/3dice/releases/3D-ICE-User_Guide.pdf))

    $ cd setup
    $ 3D-ICE-Server stack.stk 11880

Wait until "Waiting for client ..." is shown

## 2. Start SystemC Simulation

    $ ./3D-ICE-SystemC-Client

On console you will see the temperature of the configured sensor and an thermal map will be plotted at the end of the simulation to the file test.txt which can be opened with octave

    $ octave
    $ octave:1> imagesc(flipud(load("test.txt")))
