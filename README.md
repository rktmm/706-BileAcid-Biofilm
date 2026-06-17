# Project 706 Bile acid Biofilm metagenomics
Supporting bioinformatic analysis for above project.

Following scripts used were originally from: [text](https://github.com/evettehillman/BAD_project) with original edits of scripts sourced from fork: [text](https://github.com/rktmm/BAD_project).
Tried to replicate parameters (where possible) from original BAD project repo and converting it from running as slurm jobs to running in a GCP VM.
Note: Data moved from bucket to a mounted disk on VM.

Work done:
- **QC concatenated sample Fastq files**
- **Trimming** using BBDuk with FastQC of post trimming
- **Merge R1 and R2 reads**
- **Humann4 analysis** using Humann4 alpha - performed in batches
- **Humann4 and Metaphlan4 post run editing** - concatenating/merging datasets and some quality of life improvments

to be added:
conda yml file of env

# Original README of repo below:
# BAD_project
Bile acid diarrhoea PhD project 

I have around 200 samples.
Metagenomic shotgun- sequenced at a depth of 50 million reads per sample. 

I would like to use 
-	**BBDuk** (Decontamination Using Kmers) to trim adapters and other quality controls 
-	**MetaPhlAn3** (Metagenomic Phylogenetic Analysis) to a profile the composition of microbial communities from 
-	**HUMAnN3** (HMP Unified Metabolic Analysis Network) to profile the abundance of microbial metabolic pathways and other molecular functions.
I will also use FastQC and MultiQC before and after QC to check quality of reads.

The aim of this study is to compare the bacterial profile and functional gene profile between bile acid diarrhoea **(BAD)** patients, irritable bowel syndrome **(IBS)** patients and **healthy controls** .
