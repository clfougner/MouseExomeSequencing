#!/bin/bash

#name and path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSiftFiltered/422_15_2.annotated.passfiltered.vcf'

#name and path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSiftExtracted/422_15_2.annotated.passfiltered.extracted.vcf'

#name and path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/SnpSift.jar'

java -jar $JARFILE \
extractFields \
-s "," \
$INPUT \
'CHROM' 'POS' 'ID' 'QUAL' 'ANN[*].GENE' 'ANN[*].ALLELE' 'ANN[*].EFFECT' \
'ANN[*].IMPACT' 'ANN[*].GENEID' > $OUTPUT