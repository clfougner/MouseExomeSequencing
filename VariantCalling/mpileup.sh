#!/bin/bash

INPUT_TUMOR='/data2/christian/TBO150127_151231/02_bam_file/TN1511D0825.bam'
OUTPUT_TUMOR='/data2/christian/Sequencing/Output/VarScan/TN1511D0825.mpileup'
REF_FASTA='/data2/christian/Old/mm9_fasta_2/mm9_fasta_2.fa'

samtools mpileup \
$INPUT_TUMOR \
-f $REF_FASTA \
> $OUTPUT_TUMOR


INPUT_NORMAL='/data2/christian/TBO150127_151231/02_bam_file/TN1511D0825.bam'
OUTPUT_NORMAL='/data2/christian/Sequencing/Output/VarScan/TN1511D0826.mpileup'

samtools mpileup \
$INPUT_NORMAL \
-f $REF_FASTA \
> $OUTPUT_NORMAL

VARSCAN='/data2/christian/Sequencing/Frameworks/VarScan.v2.3.9.jar'
OUTPUT='/data2/christian/Sequencing/Output/VarScan/TN1511D0826.varscan.basename'

java -jar $VARSCAN \
somatic \
$OUTPUT_NORMAL \
$OUTPUT_TUMOR \
$OUTPUT_VARSCAN