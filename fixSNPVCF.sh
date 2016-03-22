#!/bin/bash

#path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.vcf'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.fixed.vcf'

python fixSNPvcf.py \
$INPUT \
20 \
$OUTPUT