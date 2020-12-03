#!/bin/bash

fuel_required=0

while read mass; do
    fuel_required=$(( $fuel_required + $mass / 3 - 2 ))
done < input

echo $fuel_required
