#!/bin/bash

mkdir -p analysis

scripts="../CASF-scripts"
data="../CASF-2016/power_scoring/CoreSet.dat"

for model in $(ls logs)
do
    echo "${model} Affinity"
    python ${scripts}/scoring_power.py \
        -c ${data} \
        -s results/${model}_Affinity.dat \
        -p negative \
        -o results/${model}_Affinity \
        > analysis/${model}_Affinity.log

    for score in "CNNscore" "CNNaffinity"
    do
        echo "${model} ${score}"
        python ${scripts}/scoring_power.py \
            -c ${data} \
            -s results/${model}_${score}.dat \
            -p positive \
            -o results/${model}_${score} \
            > analysis/${model}_${score}.log
    done
done