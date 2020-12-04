#!/bin/bash

count=0
required=( byr iyr eyr hgt hcl ecl pid )

check_passport() {
    valid=1
    for f in ${required[@]}; do
        [[ -z "${!f}" ]] && valid=0
        eval $f=
    done
    [[ $valid -eq 1 ]] && count=$(( $count + 1 ))
}

check_passport

while read line; do
    if [[ -z "$line" ]]; then
        check_passport
    else
        for pair in $line; do
            fields=( ${pair/:/ } )
            eval ${fields[0]}=${fields[1]}
        done
    fi
done < input

check_passport

echo $count
