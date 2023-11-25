#!/bin/bash
tar cvfz c128_libs_includes.tgz include/ lib/ libsrc/
makepkg -C -f -c
