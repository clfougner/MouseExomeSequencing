#!/bin/bash

#name and path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSift_filtered/401_15_output.ann.passfiltered.vcf'

#name and path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSift_extracted/401_15_output.ann.passfiltered.extracted.txt'
#name and path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/SnpSift.jar'

java -jar $JARFILE \
extractFields \
-s "," \
$INPUT \
'CHROM' 'POS' 'ID' 'QUAL' 'ANN[*].GENE' 'ANN[*].ALLELE' 'ANN[*].EFFECT' \
'ANN[*].IMPACT' 'ANN[*].GENEID' > $OUTPUT