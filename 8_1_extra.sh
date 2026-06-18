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

# split strat regrouped and renormed (but not renamed) genefamilies
cd ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_genefamilies_regrp_renorm_cpm.tsv \
--output hmn4_genefamilies_regrp_renorm_cpm_stratification_out

# metaphlan4 combine profiles
cd ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis
mkdir -p metaphlan_profiles_collated_out
find ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis \
-type f -name "*metaphlan_profile.tsv" \
! -path "*/metaphlan_profiles_collated_out/*" \
-exec cp -n -v -t ~/gcsfuse/"$project_id_out_bucket"/evette-humann-analysis/metaphlan_profiles_collated_out/ {} +

merge_metaphlan_tables.py metaphlan_profiles_collated_out/*_profile.tsv > merged_abundance_table.tsv

echo "done!"
# ad hoc additions
date -u