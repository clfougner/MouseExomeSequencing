#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input .bam file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SamSortedBams/422_15_2.sorted.bam'

#path to dedupped output
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.bam'

#path to metrics
METRICS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.metrics.txt'

#change directory to picard
#cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/



java -jar dist/picard.jar \
MarkDuplicates \
I=$INPUT \
O=$OUTPUT \
M=$METRICS

