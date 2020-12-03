#!/bin/bash

valid=0

while read line; do
    fields=( $line )
    range=( ${fields[0]/-/ } )
    required=${fields[1]:0:1}
    password=${fields[2]}
    pwdlen=${#password}
    count=0

    for (( i=0; i<$pwdlen; ++i )); do
        [[ ${password:$i:1} == $required ]] && count=$(( $count + 1 ))
    done

    (( ${range[0]} <= $count && $count <= ${range[1]} )) && valid=$(( valid + 1 ))
done < input

echo $valid
