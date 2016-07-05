#!/bin/bash

#path to output plot
OUTPUT_PLOT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalyzeCovariatesRecalibrationPlots/422_15_11.sorted.dedupped.indelrealigned.recalibrationplot.pdf'

#path to output from BaseRecalibrator.sh
RECAL_DATA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BaseRecalibratorFirstRun/422_15_11.sorted.dedupped.indelrealigned.recal_data.table'

#path to output from BaseRecalibratorSecondPass.sh
POST_RECAL_DATA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BaseRecalibratorSecondRun/422_15_11.sorted.dedupped.indelrealigned.recal_data.post_recal_data.table'

#path to reference fasta
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'


java -jar $JARFILE \
-T AnalyzeCovariates \
-R $REF_FASTA \
-before $RECAL_DATA \
-after $POST_RECAL_DATA \
-plots $OUTPUT_PLOT

