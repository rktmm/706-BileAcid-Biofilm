#!/bin/bash

# custom script for fastqc and multiqc

input_dir=/mnt/data-disk/tmp_scratch/input
output_dir=/mnt/data-disk/tmp_scratch/output/fastqc
raw_fastq_files=$(ls ${input_dir}/*fastq.gz)

mkdir -p ${output_dir}

cd ${input_dir}

source /opt/miniforge3/etc/profile.d/conda.sh
conda activate fastqc-multiqc

fastqc "$i" --threads 16 --outdir ${output_dir} ${raw_fastq_files}

cd ${output_dir}

multiqc . --interactive --ai-summary-full -n evette-combined-data-fastqc-multiqc.html

conda deactivate

echo "fastqc and multiqc done!"