#!/bin/bash

scripts="../CASF-scripts"
data="../CASF-2016/power_scoring/CoreSet.dat"

for power in "scoring" "ranking"
do
    for optname in "noopt" "amberopt" "vinaopt"
    do
        mkdir -p analysis/logs/${power}/${optname}
        mkdir -p analysis/outputs/${power}/${optname}
        
        for model in $(ls logs/${optname})
        do
            echo "${optname} ${model} Affinity"
            python ${scripts}/${power}_power.py \
                -c ${data} \
                -s results/${optname}/${model}_Affinity.dat \
                -p negative \
                -o analysis/outputs/${power}/${optname}/${model}_Affinity \
                > analysis/logs/${power}/${optname}/${model}_Affinity.log

            for score in "CNNscore" "CNNaffinity"
            do
                echo "${optname} ${model} ${score}"
                python ${scripts}/${power}_power.py \
                    -c ${data} \
                    -s results/${optname}/${model}_${score}.dat \
                    -p positive \
                    -o analysis/outputs/${power}/${optname}/${model}_${score} \
                    > analysis/logs/${power}/${optname}/${model}_${score}.log
            done
        done
    done
done