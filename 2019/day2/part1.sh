#!/bin/bash

opcodes=( $( cat input | tr , ' ' ) )
pc=0

opcodes[1]=12
opcodes[2]=2

while [[ ${opcodes[$pc]} -ne 99 ]]; do
    op=${opcodes[$pc]}
    left=${opcodes[${opcodes[$(( $pc + 1 ))]}]}
    right=${opcodes[${opcodes[$(( $pc + 2 ))]}]}
    target=${opcodes[$(( $pc + 3 ))]}
    case $op in
        1) opcodes[$target]=$(( $left + $right )) ;;
        2) opcodes[$target]=$(( $left * $right )) ;;
        *) echo "Unknown opcode $op" ;;
    esac
    echo "opcodes[$target]=${opcodes[$target]}"
    pc=$(( $pc + 4 ))
done

echo ${opcodes[0]}
