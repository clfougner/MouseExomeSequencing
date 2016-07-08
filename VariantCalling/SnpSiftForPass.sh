#!/bin/bash

#name and path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpEffAnnotated/422_15_2.annotated.vcf'

#name and path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSiftFiltered/422_15_2.annotated.passfiltered.vcf'

#name and path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/SnpSift.jar'

#Sift input for rows with FILTER=PASS
cat $INPUT | java -jar $JARFILE \
filter "(FILTER='PASS')" \
 > $OUTPUT
