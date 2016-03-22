#!/bin/bash

#connect to genlab4
#ssh chrfou@genlab4

#change to correct directory
#cd /data2/christian/GenomeAnalysisTK-3.5/

#path to tumor .bam file
TUMORBAM='/data2/christian/Reordered/TN1511D0818.dedup.reordered.bam'

#path to normal .bam file
NORMALBAM='/data2/christian/Reordered/TN1511D0819.dedup.reordered.bam'

#output
OUTPUT='/data2/christian/Output/MuTect/401_15_output_WITH_SNPS.vcf'

#path to reference .fasta file
FASTA='/data2/christian/mm9_fasta_2/mm9_fasta_2.fa'

#path to reference snp file
SNPS='/data2/christian/ReferenceFiles/2012-0612-snps+indels_FVBNJ_annotated_reordered.vcf'

#path to jarfile
JARFILE='/data2/christian/GenomeAnalysisTK3.5/GenomeAnalysisTK.jar'

#run analysis
java -jar $JARFILE \
     -T MuTect2 \
     -R $FASTA \
     -I:tumor $TUMORBAM \
     -I:normal $NORMALBAM \
     --dbsnp $SNPS \
     -nct 2 \
     -o $OUTPUT