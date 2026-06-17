#!/bin/bash

# ad hoc additions
date -u

# Load modules
source /opt/miniforge3/etc/profile.d/conda.sh
conda activate humann4a

# split strat regrouped and renormed (but not renamed) pathabundace
cd ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_pathabundance.tsv \
--output hmn4_pathabundance_stratification_out

# split strat regrouped and renormed (but not renamed) reactions
cd ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_reactions.tsv \
--output hmn4_reactions_stratification_out

echo "done!"

date -u