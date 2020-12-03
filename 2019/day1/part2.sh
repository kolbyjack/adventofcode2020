#!/bin/bash

fuel_required=0

while read mass; do
    module_fuel_required=$(( $mass / 3 - 2 ))
    fuel_required=$(( $fuel_required + $module_fuel_required ))

    while (( $module_fuel_required > 0 )); do
        module_fuel_required=$(( $module_fuel_required / 3 - 2 ))
        [[ $module_fuel_required -gt 0 ]] && fuel_required=$(( $fuel_required + $module_fuel_required ))
    done
done < input

echo $fuel_required
