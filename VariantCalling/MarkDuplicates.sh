#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input .bam file
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SamSortedBams/422_15_11.sorted.bam'

#path to dedupped output
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_11.sorted.dedupped.bam'

#path to metrics
METRICS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_11.sorted.metrics.txt'

java -jar dist/picard.jar \
MarkDuplicates \
CREATE_INDEX=true \
I=$INPUT \
O=$OUTPUT \
M=$METRICS

