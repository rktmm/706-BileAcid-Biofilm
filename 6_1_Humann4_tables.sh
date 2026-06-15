#!/bin/bash

# Script for Manipulating HumanN4 output tables

date -u

# Load modules
source /opt/miniforge3/etc/profile.d/conda.sh
conda activate humann4a

# for this particular analysis - it has been run in batches - therefore collate all tsv files into one folder
# file locations
#   ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis/humann4_out-batch-00*/
#   containing and needisolating and combining the following files:
#   *_1_metaphlan_profile.tsv
#   *_2_genefamilies.tsv
#   *_3_reactions.tsv
#   *_4_pathabundance.tsv

cd ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis
mkdir -p hmn4_collated_out
find ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis \
-type f \( -name "*genefamilies.tsv" -o \
-name "*reactions.tsv" -o \
-name "*pathabundance.tsv" \) \
! -path "*/hmn4_collated_out/*" \
-exec cp -n -v -t ~/gcsfuse/mhra-ngs-dev-b9su_output/evette-humann-analysis/hmn4_collated_out/ {} +
# all files in /hmn4_collated_out

# combine sample tables for gene families, reactions, and pathway abundance
echo "######## Running join tables"
humann_join_tables --input hmn4_collated_out \
--output hmn4_genefamilies.tsv --file_name genefamilies
humann_join_tables --input hmn4_collated_out \
--output hmn4_reactions.tsv --file_name reactions
humann_join_tables --input hmn4_collated_out \
--output hmn4_pathabundance.tsv --file_name pathabundance

# re-normalise tables (with cpm) for cross-comparison bw samples
echo "######## Running renormalisation of tables"
humann_renorm_table --input hmn4_genefamilies.tsv \
--units cpm \
--output hmn4_genefamilies_renorm_cpm.tsv
humann_renorm_table --input hmn4_reactions.tsv \
--units cpm \
--output hmn4_reactions_renorm_cpm.tsv
humann_renorm_table --input hmn4_pathabundance.tsv \
--units cpm \
--output hmn4_pathabundance_renorm_cpm.tsv

# split stratified by bugs 
echo "######## Running split stratification of tables"
humann_split_stratified_table --input hmn4_genefamilies_renorm_cpm.tsv \
--output hmn4_genefamilies_renorm_cpm_stratification
humann_split_stratified_table --input hmn4_reactions_renorm_cpm.tsv \
--output hmn4_reactions_renorm_cpm_stratification
humann_split_stratified_table --input hmn4_pathabundance_renorm_cpm.tsv \
--output hmn4_pathabundance_renorm_stratification

# regroup for genefamilies
echo "######## Running gene families regroup tables"
humann_regroup_table --input hmn4_genefamilies_renorm_cpm_stratification/hmn4_genefamilies_renorm_cpm_unstratified.tsv \
--output hmn4_genefamilies_renorm_cpm_unstratified_regr.tsv \
--groups uniref90_ko

# Rename
echo "######## Running rename tables"
humann_rename_table --input hmn4_genefamilies_renorm_cpm_unstratified_regr.tsv \
--output hmn4_genefamilies_renorm_cpm_unstratified_regr_ko_named.tsv \
--names kegg-orthology
humann_rename_table --input hmn4_pathabundance_renorm_stratification/hmn4_pathabundance_renorm_cpm_unstratified.tsv \
--output hmn4_pathabundance_renorm_cpm_unstratified_metcy_named.tsv \
--names metacyc-pwy
humann_rename_table --input hmn4_reactions_renorm_cpm_stratification/hmn4_reactions_renorm_cpm_unstratified.tsv \
--output hmn4_reactions_renorm_cpm_unstratified_metcy_named.tsv \
--names metacyc-rxn

date -u

echo "done!"
