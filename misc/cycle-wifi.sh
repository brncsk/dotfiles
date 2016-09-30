#!/bin/sh

while :
do
    if ! ping -i 0.5 -c 2 -t 1 mjn.anadrome.org > /dev/null
    then
        # networksetup -setairportpower en0 off; networksetup -setairportpower en0 on  # This can run as non-root 
        echo "add State:/Network/Interface/en0/RefreshConfiguration temporary" | scutil # This is root only
        echo "Dropout:" `date`
    fi
done
