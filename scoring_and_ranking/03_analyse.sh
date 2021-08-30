#!/bin/bash

scripts="../CASF-scripts"
data="../CASF-2016/power_scoring/CoreSet.dat"

for power in "scoring" "ranking"
do
    mkdir -p analysis/logs/${power}
    mkdir -p analysis/outputs/${power}

    for model in $(ls logs)
    do
        echo "${model} Affinity"
        python ${scripts}/${power}_power.py \
            -c ${data} \
            -s results/${model}_Affinity.dat \
            -p negative \
            -o results/${power}/${model}_Affinity \
            > analysis/${power}/${model}_Affinity.log

        for score in "CNNscore" "CNNaffinity"
        do
            echo "${model} ${score}"
            python ${scripts}//${power}_power.py \
                -c ${data} \
                -s results/${model}_${score}.dat \
                -p positive \
                -o results/${power}/${model}_${score} \
                > analysis/${power}/${model}_${score}.log
        done
    done
done