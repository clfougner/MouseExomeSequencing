#!/bin/bash

#path to dbSNP textfile
DBSNP='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/snp128.txt'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/snp128.vcf'

#path to FASTA reference file
FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm9_fasta_2.fa'

#path to GATK jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/GenomeAnalysisTK3.5/GenomeAnalysisTK.jar'



java -jar $JARFILE \
-R $FASTA \
-T VariantsToVCF \
--variant:OLDDBSNP $DBSNP \
-o $OUTPUT