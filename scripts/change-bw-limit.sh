#!/bin/bash

#USAGE: change-bw-limit.sh 1/2 [0-1]#

if [[ $1 -eq 1 ]]; then
FILE=$VPP_ROOT/src/vnet/ip/flow_table.h
fi

if [[ $1 -eq 2 ]]; then
FILE=$VPP_ROOT/src/vnet/ip/fifo.h
fi

if [[ ( $(echo $2 | awk -F "." '{print $1}') -gt 0 ) && ( $(echo $2 | awk -F "." '{print $2}') -gt 0 ) ]] ; then
    echo 'Error, bandwidth cannot be greater than 100%. Usage:'
    echo './change-bw-limit.sh <1/2> <number [0-1]>'
    exit 1
fi

sed -i "s/^\(#define ALPHA \).*/\1$2/" $FILE
