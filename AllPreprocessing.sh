#!/bin/bash

#path to known indels
INDELS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.FVBN.INDELS.vcf'

#path to known SNPs
SNPS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.FVBN.SNPs.vcf'

#path to jarfile
GATK_JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'

#path to reference FASTA
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'


#BWAmem.sh
#path to FASTQinput files
INPUT_FASTQ1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0825/TN1511D0825_1.fastq'
INPUT_FASTQ2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0825/TN1511D0825_2.fastq'

#path to output file
OUTPUT_BAM='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BWAmemAlignedBams/422_15_2.bam'

bwa mem \
-R '@RG\tID:foo\tSM:bar\tPL:Illumina' \
$REF_FASTA \
$INPUT_FASTQ1 $INPUT_FASTQ2 > \
$OUTPUT_BAM


#SortSam.sh
cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input .bam file
INPUT_SORTSAM='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BWAmemAlignedBams/422_15_2.bam'

#path to output.bam file
OUTPUT_SORTSAM='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SamSortedBams/422_15_2.sorted.bam'

java -jar dist/picard.jar \
SortSam \
I=$INPUT_SORTSAM \
O=$OUTPUT_SORTSAM \
SORT_ORDER=coordinate


#MarkDuplicates.sh
cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to input .bam file
INPUT_MARKDUPLICATES='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SamSortedBams/422_15_2.sorted.bam'

#path to dedupped output
OUTPUT_MARKDUPLICATES='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.bam'

#path to metrics
METRICS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/Metrics/422_15_2.sorted.metrics.txt'

java -jar dist/picard.jar \
MarkDuplicates \
CREATE_INDEX=true \
I=$INPUT_MARKDUPLICATES \
O=$OUTPUT_MARKDUPLICATES \
M=$METRICS


#RealignerTargetCreator.sh
#path to input file (dedupped)
INPUT_REALIGNERTARGETCREATOR='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.bam'

#path to and name of output file
OUTPUT_REALIGNERTARGETCREATOR='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/RealignerTargetCreator/422_15_2.sorted.dedupped.realigment_targets.list'

java -jar $GATK_JARFILE \
-T RealignerTargetCreator \
-R $REF_FASTA \
-I $INPUT_REALIGNERTARGETCREATOR \
-known $INDELS \
-o $OUTPUT_REALIGNERTARGETCREATOR


#IndelRealigner.sh

#path to output
OUTPUT_INDELREALIGNER='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/IndelRealigned/422_15_2.sorted.dedupped.indelrealigned.bam'

java -jar $GATK_JARFILE \
-T IndelRealigner \
-R $REF_FASTA \
-I $INPUT_REALIGNERTARGETCREATOR \
-targetIntervals $OUTPUT_REALIGNERTARGETCREATOR \
-known $INDELS \
-o $OUTPUT_INDELREALIGNER


#BaseRecalibrator.sh
#path to output file (bam fafter realignment around indels)
RECAL_DATA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BaseRecalibratorFirstRun/422_15_2.sorted.dedupped.indelrealigned.recal_data.table'

java -jar $GATK_JARFILE \
-T BaseRecalibrator \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER \
-knownSites $SNPS \
-knownSites $INDELS \
-o $RECAL_DATA

#BaseRecalibratorSecondPass.sh
#path to output data table
POST_RECAL_DATA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/BaseRecalibratorSecondRun/422_15_2.sorted.dedupped.indelrealigned.recal_data.post_recal_data.table'

java -jar $GATK_JARFILE \
-T BaseRecalibrator  \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER \
-knownSites $SNPS \
-knownSites $INDELS \
-BQSR $RECAL_DATA \
-o $POST_RECAL_DATA   


#AnalyzeCovariates.sh
#path to output plot
ANALYZECOVARIATES_PLOT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalyzeCovariatesRecalibrationPlots/422_15_2.sorted.dedupped.indelrealigned.recalibrationplot.pdf'

java -jar $GATK_JARFILE \
-T AnalyzeCovariates \
-R $REF_FASTA \
-before $RECAL_DATA \
-after $POST_RECAL_DATA \
-plots $ANALYZECOVARIATES_PLOT


#PrintReads.sh
#path to output file (recalibrated .bam file)
RECALIBRATED_OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/PrintReadsRecalibrated/422_15_2.sorted.dedupped.indelrealigned.addedreadgroups.recalibrated.bam'

java -jar $GATK_JARFILE \
-T PrintReads \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER \
-BQSR $RECAL_DATA \
-o $RECALIBRATED_OUTPUT
