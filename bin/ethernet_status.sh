#!/bin/sh
 
echo "%{F#008a0b}歷 %{F#ffffff}$(/usr/sbin/ifconfig wlp3s0 | grep "inet" | awk '{print $2}')%{u-}" 
