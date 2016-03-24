#!/bin/bash

#path to output file (recalibrated .bam file)
RECALIBRATED_OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/PrintReadsRecalibrated/422_15_11.sorted.dedupped.indelrealigned.addedreadgroups.recalibrated.bam'

#path to input file (bam fafter realignment around indels)
REALIGNED_BAM_INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/422_15_11.sorted.dedupped.indelrealigned.addedreadgroups.bam'

#path to recalibrated .table file
RECAL_DATA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BaseRecalibratorFirstRun/422_15_11.sorted.dedupped.indelrealigned.recal_data.table'

#path to reference fasta
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'


java -jar $JARFILE \
-T PrintReads \
-R $REF_FASTA \
-I $REALIGNED_BAM_INPUT \
-BQSR $RECAL_DATA \
-o $RECALIBRATED_OUTPUT