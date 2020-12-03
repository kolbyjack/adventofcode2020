#!/bin/bash

SUM=2020
SEEN=( )

while read coins; do
    if (( $coins < 0 )) || (( $coins > $SUM )); then
        continue
    fi

    SEEN[$coins]=1
    if [[ ${SEEN[$(( $SUM - $coins ))]} -eq 1 ]]; then
        product=$(( $coins * ($SUM - $coins) ))
        echo "$coins * $(( $SUM - $coins )) = $product"
        break
    fi
done < input
