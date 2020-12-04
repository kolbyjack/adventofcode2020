#!/bin/bash

count=0
required=( byr iyr eyr hgt hcl ecl pid )

check_string() {
    local str=$1
    local reqlen=$2
    local allowed=$3

    [[ ${#str} -ne $reqlen ]] && return 1

    for (( i=0; i<$reqlen; ++i )); do
        c=${str:$i:1}
        [[ $allowed == *$c* ]] || return 1
    done

    return 0
}

check_passport() {
    valid=1
    for f in ${required[@]}; do
        [[ -z "${!f}" ]] && valid=0
    done

    if [[ $valid -eq 1 ]]; then
        [[ $byr -lt 1920 || $byr -gt 2002 ]] && valid=0
        [[ $iyr -lt 2010 || $iyr -gt 2020 ]] && valid=0
        [[ $eyr -lt 2020 || $eyr -gt 2030 ]] && valid=0
        case $hgt in
            *cm) hgt=${hgt/cm/}; [[ $hgt -lt 150 || $hgt -gt 193 ]] && valid=0 ;;
            *in) hgt=${hgt/in/}; [[ $hgt -lt 59 || $hgt -gt 76 ]] && valid=0 ;;
            *) valid=0 ;;
        esac
        ( [[ ${hcl:0:1} == '#' ]] && check_string ${hcl:1} 6 0123456789abcdef ) || valid=0
        case $ecl in
            amb|blu|brn|gry|grn|hzl|oth) ;;
            *) valid=0 ;;
        esac
        check_string $pid 9 0123456789 || valid=0
    fi

    [[ $valid -eq 1 ]] && count=$(( $count + 1 ))

    for f in ${required[@]}; do
        eval $f=
    done
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
