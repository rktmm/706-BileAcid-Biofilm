#!/bin/bash

# ad hoc additions
date -u

# Usage: bash $0 <project_ID_out_bucket>

project_id_out_bucket="$1"

if [[ -z "$project_id" ]]; then 
    echo " Usage: bash $0 <project_ID_out_bucket>"
    exit 1
fi

# Load modules
source /opt/miniforge3/etc/profile.d/conda.sh
conda activate humann4a

# split strat regrouped and renormed (but not renamed) pathabundace
cd ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_pathabundance.tsv \
--output hmn4_pathabundance_stratification_out

# split strat regrouped and renormed (but not renamed) reactions
cd ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_reactions.tsv \
--output hmn4_reactions_stratification_out

echo "done!"

date -u