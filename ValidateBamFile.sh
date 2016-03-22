#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input file for validation
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.addedreadgroups.bam'

java -jar dist/picard.jar \
ValidateSamFile \
I=$INPUT \
MODE=SUMMARY