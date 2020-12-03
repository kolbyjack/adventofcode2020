#!/bin/bash

SUM=2020
SEEN=( )
PARTIALS=( )

while read coins; do
    if (( $coins < 0 )) || (( $coins > $SUM )); then
        continue
    fi

    complement=$(( $SUM - $coins ))

    if [[ ${PARTIALS[$complement]} != "" ]]; then
        product=$coins
        echo -n "$coins"
        for operand in ${PARTIALS[$complement]}; do
            echo -n " * $operand"
            product=$(( $product * $operand ))
        done
        echo " = $product"
        echo $product
        break
    fi

    for oldcoins in ${SEEN[@]}; do
        PARTIALS[$(( $coins + $oldcoins ))]="$oldcoins $coins"
    done
    SEEN+=( $coins )
done < input
