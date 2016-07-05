#!/bin/bash

#path to annotated output
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpEffAnnotated/422_15_2.annotated.vcf'

#path to input vcf
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/MuTect2/422_15_2.vcf'

#SnpEff reference genome version
SNPEFF_REFERENCE='GRCm38.82'

#Path to stats
STATS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SnpEffAnnotated/422_15_2.summary.html'

#Path to SnpEff jarfile
SNPEFF_JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/snpEff.jar'

java -Xmx4g -jar $SNPEFF_JARFILE \
$SNPEFF_REFERENCE \
-v -stats $STATS \
$INPUT > \
$OUTPUT
 