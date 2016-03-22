#!/bin/bash

#name and path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpEff_annotated/401_15/401_15_output.ann.vcf'

#name and path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpSift_filtered/401_15_output.ann.passfiltered.vcf'

#name and path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/SnpSift.jar'

#Sift input for rows with FILTER=PASS
cat $INPUT | java -jar $JARFILE \
filter "(FILTER='PASS')" \
 > $OUTPUT
