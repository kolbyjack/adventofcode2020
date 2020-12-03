#!/bin/bash

valid=0

while read line; do
    fields=( $line )
    range=( ${fields[0]/-/ } )
    required=${fields[1]:0:1}
    password=" ${fields[2]}"
    count=0

    [[ ${password:${range[0]}:1} == $required ]] && count=$(( count + 1 ))
    [[ ${password:${range[1]}:1} == $required ]] && count=$(( count + 1 ))
    [[ $count -eq 1 ]] && valid=$(( valid + 1 ))
done < input

echo $valid
