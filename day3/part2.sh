#!/bin/bash

slopes=( 1 3 5 7 )
counts=( 0 0 0 0 0 )
y=0

while read line; do
    for (( i=0; i<4; ++i )); do
        x=$(( ($y * ${slopes[i]}) % ${#line} ))
        [[ ${line:$x:1} == "#" ]] && counts[$i]=$(( ${counts[$i]} + 1 ))
    done

    if [[ $(( $y % 2 )) -eq 0 ]]; then
        x=$(( ($y / 2) % ${#line} ))
        [[ ${line:$x:1} == "#" ]] && counts[4]=$(( ${counts[4]} + 1 ))
    fi

    y=$(( $y + 1 ))
done < input

product=1
for op in ${counts[@]}; do
    product=$(( $product * $op ))
done

echo $product
