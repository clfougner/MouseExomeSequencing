#!/bin/bash

#path to input file (dedupped)
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Reordered/TN1511D0818.dedup.reordered.bam'

#path to and name of output file
REALIGNMENT_TARGETS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/IndelRealigner/TN1511D0818.dedup.reordered.realigned.bam'

#path to and name of output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/RealignerTargetCreator/TN1511D0818.dedup.reordered.list'

#path to reference fasta
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm9_fasta_2.fa'

#path to known indels
INDELS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/2012-0612-snps+indels_FVBNJ_annotated_reordered.vcf'

#path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'

java -jar $JARFILE \
-T IndelRealigner \
-R $REF_FASTA \
-I $INPUT \
-targetIntervals $REALIGNMENT_TARGETS \
-known $INDELS \
-o $OUTPUT