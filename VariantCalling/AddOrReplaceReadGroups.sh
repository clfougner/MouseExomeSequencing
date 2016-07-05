#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/IndelRealigned/422_15_11.sorted.dedupped.indelrealigned.bam'

#path to output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/422_15_11.sorted.dedupped.indelrealigned.addedreadgroups.bam'

java -jar dist/picard.jar \
AddOrReplaceReadGroups \
I=$INPUT \
O=$OUTPUT \
RGID=4 \
RGLB=lib1 \
RGPL=illumina \
RGPU=unit1 \
RGSM=20