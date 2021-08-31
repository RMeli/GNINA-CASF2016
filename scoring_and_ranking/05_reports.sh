#!/bin/bash

metric="Pearson"
fout="${metric}.csv"
echo "score,model,opt,metric,cilow,cihigh" > ${fout}
for optname in "noopt" "amberopt" "vinaopt"
do
    for model in $(ls logs/${optname})
    do
        for score in "Affinity" "CNNscore" "CNNaffinity"
        do
            file="analysis/logs/scoring/${optname}/${model}_${score}.log"
            cifile="analysis/outputs/scoring/${optname}/${model}_${score}-ci.results"

            # Get value of METRIC
            # Retain only first occurence (other occurrences are from R script)
            m=$(grep -m 1 "${metric}" ${file} | awk '{ print $NF }')
            
            # Get confidence interval (both low and high limits)
            ci=$(grep "90%" ${cifile} | awk '{ print $3$4 }')

            echo "${score},${model},${optname},${m},${ci}" >> ${fout}
        done
    done
done

for metric in "Spearman" # TODO: Add Kendall and PI
do
    fout="${metric}.csv"
    echo "score,model,opt,metric,cilow,cihigh" > ${fout}
    for optname in "noopt" "amberopt" "vinaopt"
    do
        for model in $(ls logs/${optname})
        do
            for score in "Affinity" "CNNscore" "CNNaffinity"
            do
                file="analysis/logs/ranking/${optname}/${model}_${score}.log"
                cifile="analysis/outputs/ranking/${optname}/${model}_${score}_${metric}-ci.results"

                # Get value of METRIC
                # Retain only first occurence (other occurrences are from R script)
                m=$(grep -m 1 "${metric}" ${file} | awk '{ print $NF }')
                
                # Get confidence interval (both low and high limits)
                ci=$(grep "90%" ${cifile} | awk '{ print $3$4 }')

                echo "${score},${model},${optname},${m},${ci}" >> ${fout}
            done
        done
    done
done
