#!/bin/bash

count=0
y=0

while read line; do
    x=$(( ($y * 3) % ${#line} ))
    [[ ${line:$x:1} == "#" ]] && count=$(( $count + 1 ))
    y=$(( $y + 1 ))
done < input

echo $count
