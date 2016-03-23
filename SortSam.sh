#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input .bam file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BWAmemAlignedBams/422_15_11.bam'

#path to output.bam file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SamSortedBams/422_15_11.sorted.bam'

java -jar dist/picard.jar \
SortSam \
I=$INPUT \
O=$OUTPUT \
SORT_ORDER=coordinate