#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input file for validation
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/IndelRealigned/422_15_11.sorted.dedupped.indelrealigned.bam'

java -jar dist/picard.jar \
ValidateSamFile \
I=$INPUT \
MODE=SUMMARY