#!/bin/bash

original_opcodes=( $( cat input | tr , ' ' ) )

for noun in {0..99}; do
    for verb in {0..99}; do
        opcodes=( ${original_opcodes[@]} )
        pc=0

        opcodes[1]=$noun
        opcodes[2]=$verb

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
            pc=$(( $pc + 4 ))
        done

        if [[ ${opcodes[0]} -eq 19690720 ]]; then
            echo $(( $noun * 100 + $verb ))
            exit
        fi
    done
done

