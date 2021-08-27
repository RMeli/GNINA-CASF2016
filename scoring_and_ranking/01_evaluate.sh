#!/bin/bash

container="../singularity/gnina.sif"

coreset="../CASF-2016/coreset"
data="../CASF-2016/power_scoring/CoreSet.dat"

mkdir -p logs

models="default redock_default2018 general_default2018 crossdock_default2018 dense"

for model in ${models}
do
    mkdir -p logs/${model}

    for system in $(tail -n +2 ${data} | awk '{print $1}')
    do
        ligand="${coreset}/${system}/${system}_ligand.mol2"
        receptor="${coreset}/${system}/${system}_protein.pdb"

        singularity run --nv --app gnina ${container} \
            -l ${ligand} \
            -r ${receptor} \
            --autobox_ligand ${ligand} \
            --score_only \
            --cnn "${model}_ensemble" \
            > logs/${model}/${system}.log
    done
done
