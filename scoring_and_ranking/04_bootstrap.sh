#!/bin/bash

bootsrap()
{
    power=$1
    optname=$2
    model=$3

    for score in "Affinity" "CNNscore" "CNNaffinity"
    do
            logfile="analysis/logs/${power}/${optname}/${model}_${score}.log"
            
            # Only one script for scoring (Pearson)
            # Assumes only one script for ranking (Spearman)
            rscript="analysis/logs/${power}/${optname}/${model}_${score}.r"

            # Delete all lines from 1 until the match (included)
            sed -e '1,/Template command for running the bootstrap in R/d' ${logfile} | head -n -1 > ${rscript}
    
            Rscript --vanilla ${rscript}
    done
}
export -f bootsrap

powers="scoring ranking"
optnames="noopt amberopt vinaopt"
models=$(ls logs/noopt/) # Assumes same models for all optname

parallel -j 10 bootsrap ::: ${powers} ::: ${optnames} ::: ${models}
