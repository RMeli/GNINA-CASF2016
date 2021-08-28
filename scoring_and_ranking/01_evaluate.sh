#!/bin/bash

container="../singularity/gnina.sif"

coreset="../CASF-2016/coreset"
data="../CASF-2016/power_scoring/CoreSet.dat"

mkdir -p logs

models="default redock_default2018 general_default2018 crossdock_default2018 dense"

# No optimisation
optname="noopt"
mkdir -p logs/${optname}
for model in ${models}
do
    mkdir -p logs/${optname}/${model}

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
            --seed 42 \
            > logs/${optname}/${model}/${system}.log
    done
done

# Amber (CASF2016) optimisation
optname="amberopt"
mkdir -p logs/${optname}
for model in ${models}
do
    mkdir -p logs/${optname}/${model}

    for system in $(tail -n +2 ${data} | awk '{print $1}')
    do
        ligand="${coreset}/${system}/${system}_ligand_opt.mol2"
        receptor="${coreset}/${system}/${system}_protein.pdb"

        singularity run --nv --app gnina ${container} \
            -l ${ligand} \
            -r ${receptor} \
            --autobox_ligand ${ligand} \
            --score_only \
            --cnn "${model}_ensemble" \
            --seed 42 \
            > logs/${optname}/${model}/${system}.log
    done
done

# Vina optimisation
optname="vinaopt"
mkdir -p logs/${optname}
for model in ${models}
do
    mkdir -p logs/${optname}/${model}

    for system in $(tail -n +2 ${data} | awk '{print $1}')
    do
        ligand="${coreset}/${system}/${system}_ligand.mol2"
        receptor="${coreset}/${system}/${system}_protein.pdb"

        singularity run --nv --app gnina ${container} \
            -l ${ligand} \
            -r ${receptor} \
            --autobox_ligand ${ligand} \
            --minimize \
            --cnn "${model}_ensemble" \
            --seed 42 \
            > logs/${optname}/${model}/${system}.log
    done
done
