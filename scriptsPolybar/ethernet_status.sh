#!/bin/sh  

echo "%{F#CE93D8} %{F#ffffff}$(/usr/bin/hostname -I | awk '{print $1}')%{u-}"
