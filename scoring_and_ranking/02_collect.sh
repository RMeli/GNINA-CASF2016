#!/bin/bash

#!/bin/bash

data="../CASF-2016/power_scoring/CoreSet.dat"

scores="Affinity CNNscore CNNaffinity"

for optname in "noopt" "amberopt" "vinaopt"
do
    mkdir -p results/${optname}
    for model in $(ls logs)
    do
        for score in ${scores}
        do
            echo ${optname} ${model} ${score}

            fout="results/${optname}/${model}_${score}.dat"

            echo "#code  score" > ${fout}
            for system in $(tail -n +2 ${data} | awk '{print $1}')
            do
                flog="logs/${optname}/${model}/${system}.log"
                s=$(grep "^${score}:" ${flog} | awk '{print $2}')

                echo "${system} ${s}" >> ${fout}
            done
        done
    done
done