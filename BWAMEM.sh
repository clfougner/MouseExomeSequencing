#!/bin/bash

#path to input files
INPUT1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_1.fastq'
INPUT2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_2.fastq'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BWAmemAlignedBams/422_15_11.bam'

#path to reference FASTA
FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

bwa mem \
-R '@RG\tID:foo\tSM:bar\tPL:Illumina' \
$FASTA \
$INPUT1 $INPUT2 > \
$OUTPUT


