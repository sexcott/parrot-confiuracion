#!/bin/bash
 
ip_address=$(cat /home/sexcott/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/sexcott/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#008a0b}什 %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#008a0b}什%{u-}%{F#ffffff} No target"
fi
