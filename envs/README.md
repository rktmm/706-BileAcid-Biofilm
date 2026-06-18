## Environments

Outlining conda environments used by RM on GCP VM.

I created the environments using 'mamba' but you can use either 'mamba' or 'conda'

Note: I prefer installing metaphlan and hummann with mamba as it is a lot faster 

env.yml files should be in the /envs folder for the following:

BBtools
FastQC and MultiQC
Hummann4

### Details regarding metaphlan4 and humann4 environment
- humann=4.0.0a1
- metaphlan=4.1.1

Check in the biobakery forums regarding compatability of downloaded humann vs metaphlan versions.

I manually installed the following databases:

**mpa_vOct22_CHOCOPhlAnSGB_202403**
metaphlan --install --bowtie2db /mnt/data-disk/tmp_scratch/database/metaphlan_db/ --index mpa_vOct22_CHOCOPhlAnSGB_202403

**uniref90_ec_filtered_diamond**
humann_databases --download uniref uniref90_ec_filtered_diamond /mnt/data-disk/tmp_scratch/database/humann4_db/

**utility_mapping**
humann_databases --download utility_mapping full /mnt/data-disk/tmp_scratch/database/humann4_db/

**chocophlan**
humann_databases --download chocophlan full /mnt/data-disk/tmp_scratch/database/humann4_db/
