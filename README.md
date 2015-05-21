de.uni-kl.ems.dram.vp.icewrapper
================================

This repository shows a wrapper for 3D-ICE in a SystemC based simulation.

# Basic Setup

Configure the paths to:

    - SuperLU 4.3
    - 3D-ICE 2.2.5
    - SystemC 2.3

in the 3D-ICE-SystemC-Client.pro file.

Run qmake and make:

    $ qmake 3D-ICE-SystemC-Client.pro
    $ make

# Starting Simulation

## 1. Start 3D-ICE Simulation Server 

    $ cd setup
    $ 3D-ICE-Server stack.stk 11880

Wait until "Waiting for client ..." is shown

## 2. Start SystemC Simulation

    $ ./3D-ICE-SystemC-Client

On console you will see the temperature of the configured sensor and an thermal map will be plotted at the end of the simulation to the file test.txt which can be opened with octave

    $ octave
    $ octave:1> imagesc(flipud(load("test.txt")))
