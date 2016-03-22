#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.bam'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.addedreadgroups.bam'

java -jar dist/picard.jar \
AddOrReplaceReadGroups \
I=$INPUT \
O=$OUTPUT \
RGID=4 \
RGLB=lib1 \
RGPL=illumina \
RGPU=unit1 \
RGSM=20