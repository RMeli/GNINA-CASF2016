#!/bin/bash

#!/bin/bash

data="../CASF-2016/power_scoring/CoreSet.dat"

mkdir -p results

scores="Affinity CNNscore CNNaffinity"

for model in $(ls logs)
do
    for score in ${scores}
    do
        echo ${model} ${score}

        fout="results/${model}_${score}.dat"

        echo "#code  score" > ${fout}
        for system in $(tail -n +2 ${data} | awk '{print $1}')
        do
            flog="logs/${model}/${system}.log"
            s=$(grep "^${score}:" ${flog} | awk '{print $2}')

            echo "${system} ${s}" >> ${fout}
        done
    done
done