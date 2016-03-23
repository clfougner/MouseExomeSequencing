#!/bin/bash

#Generate Fasta file index
#Samtools must be installed
#ref: https://www.broadinstitute.org/gatk/guide/article?id=2798


INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'
samtools faidx $INPUT

