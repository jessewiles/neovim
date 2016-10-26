#!/bin/bash

fname=$1

while [[ 1 ]]; do
    curr=$(pwd)
    if [ -e "$fname" ]; then
        exit 0
    else
        if [ "$curr" = "/" ]; then
            exit 1
        else
            cd ..
        fi
    fi
done
