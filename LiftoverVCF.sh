#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/SNPs/2012-0612-snps+indels_FVBNJ_annotated.vcf'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.fixed.vcf'

#path to chain file
CHAINFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm9ToMm10.over.chain'

#file for rejected variants
REJECTED='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/RejectedFromLiftover.vcf'

#path to reference sequence
REFERENCE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'


java -jar dist/picard.jar \
LiftoverVcf \
I=$INPUT \
O=$OUTPUT \
CHAIN=$CHAINFILE \
REJECT=$REJECTED \
R=$REFERENCE