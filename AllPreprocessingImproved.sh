#!/bin/bash

#Sample numbers
SAMPLE_NORMAL='422_15_11'
SAMPLE_TUMOR='422_15_2'

#Path to FASTQ input files
INPUT_FASTQ_NORMAL_1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_1.fastq'
INPUT_FASTQ_NORMAL_2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_2.fastq'
INPUT_FASTQ_TUMOR_1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0825/TN1511D0825_1.fastq'
INPUT_FASTQ_TUMOR_2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0825/TN1511D0825_2.fastq'

#Path to known indels
INDELS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.FVBN.INDELS.vcf'

#Path to known SNPs
SNPS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.FVBN.SNPs.vcf'

#Path to GATK jar file
GATK_JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'

#Path to reference FASTA
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#Path to folder containing Picard.jar
PICARD_PATH='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/'

#Master path to output folder
MASTER='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/'

#Number of threads for variant calling (MuTect, nct argument)
NCT='2'

#Names of folders needed in output folder
#mkdir BWAmemAlignedBams
#mkdir SamSortedBams
#mkdir DeduppedBams
#mkdir /DeduppedBams/Metrics
#mkdir RealignerTargetCreator
#mkdir IndelRealigned
#mkdir BaseRecalibratorFirstRun
#mkdir BaseRecalibratorSecondRun
#mkdir AnalyzeCovariatesRecalibrationPlots
#mkdir PrintReadsRecalibrated


#NORMAL
#Map read to reference genome (BWAmem.sh)
#Path to output bam file
OUTPUT_BWA_PATH='BWAmemAlignedBams/'
OUTPUT__BWA_EXTENSION='.bam'
OUTPUT_BWA_NORMAL=$MASTER$OUTPUT_BWA_PATH$SAMPLE_NORMAL$OUTPUT_BWA_EXTENSION

bwa mem \
-R '@RG\tID:foo\tSM:bar\tPL:Illumina' \
$REF_FASTA \
$INPUT_FASTQ_NORMAL_1 $INPUT_FASTQ_NORMAL_2 > \
$OUTPUT_BWA_NORMAL


#Sort mapped reads by coordinate (SortSam.sh)

cd $PICARD_PATH

#Path to coordinate sorted bam file
OUTPUT_SORTSAM_PATH='SamSortedBams/'
OUTPUT_SORTSAM_EXTENSION='.sorted.bam'
OUTPUT_SORTSAM_NORMAL=$MASTER$OUTPUT_SORTSAM_PATH$SAMPLE_NORMAL$OUTPUT_SORTSAM_EXTENSION

java -jar dist/picard.jar \
SortSam \
I=$OUTPUT_BWA_NORMAL \
O=$OUTPUT_SORTSAM_NORMAL \
SORT_ORDER=coordinate


#Mark duplicates (MarkDuplicates.sh)
cd $PICARD_PATH

#Path to dedupped output
OUTPUT_MARKDUPLICATES_PATH='DeduppedBams/'
OUTPUT_MARKDUPLICATES_EXTENSION='.sorted.dedupped.bam'
OUTPUT_MARKDUPLICATES_NORMAL=$MASTER$OUTPUT_MARKDUPLICATES_PATH$SAMPLE_NORMAL$OUTPUT_MARKDUPLICATES_EXTENSION

#Path to metrics for deduplication
METRICS_PATH='DeduppedBams/Metrics/'
METRICS_EXTENSION='.sorted.metrics.txt'
METRICS_NORMAL=$MASTER$METRICS_PATH$SAMPLE_NORMAL$METRICS_EXTENSION

java -jar dist/picard.jar \
MarkDuplicates \
CREATE_INDEX=true \
I=OUTPUT_SORTSAM_NORMAL \
O=$OUTPUT_MARKDUPLICATES_NORMAL \
M=$METRICS_NORMAL


#Create realignment targets (RealignerTargetCreator.sh)
#Path to output realignment target list
OUTPUT_REALIGNERTARGETCREATOR_PATH='RealignerTargetCreator/'
OUTPUT_REALIGNERTARGETCREATOR_EXTENSION='.sorted.dedupped.realignment_targets.list'
OUTPUT_REALIGNERTARGETCREATOR_NORMAL=$MASTER$OUTPUT_REALIGNERTARGETCREATOR_PATH$SAMPLE_NORMAL$OUTPUT_REALIGNERTARGETCREATOR_EXTENSION

java -jar $GATK_JARFILE \
-T RealignerTargetCreator \
-R $REF_FASTA \
-I $OUTPUT_MARKDUPLICATES_NORMAL \
-known $INDELS \
-o $OUTPUT_REALIGNERTARGETCREATOR_NORMAL


#Realign around indels (IndelRealigner.sh)
#Path to realigned bam file
OUTPUT_INDELREALIGNER_PATH='IndelRealigned/'
OUTPUT_INDELREALIGNER_EXTENSION='.sorted.dedupped.indelrealigned.bam'
OUTPUT_INDELREALIGNER_NORMAL=$MASTER$OUTPUT_INDELREALIGNER_PATH$SAMPLE_NORMAL$OUTPUT_INDELREALIGNER_EXTENSION

java -jar $GATK_JARFILE \
-T IndelRealigner \
-R $REF_FASTA \
-I $OUTPUT_MARKDUPLICATES_NORMAL \
-targetIntervals $OUTPUT_REALIGNERTARGETCREATOR_NORMAL \
-known $INDELS \
-o $OUTPUT_INDELREALIGNER_NORMAL


#Create base recalibration data table (BaseRecalibrator.sh)
#Path to output recalibration data table
RECAL_DATA_PATH='BaseRecalibratorFirstRun/'
RECAL_DATA_EXTENSION='.sorted.dedupped.indelrealigned.recal_data.table'
RECAL_DATA_NORMAL=$MASTER$RECAL_DATA_PATH$SAMPLE_NORMAL$RECAL_DATA_EXTENSION

java -jar $GATK_JARFILE \
-T BaseRecalibrator \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_NORMAL \
-knownSites $SNPS \
-knownSites $INDELS \
-o $RECAL_DATA_NORMAL

#Second base recalibration data table for recalibration plot (BaseRecalibratorSecondPass.sh)
#Path to output recalibration data table
POST_RECAL_DATA_PATH='BaseRecalibratorSecondRun/'
POST_RECAL_DATA_EXTENSION='.sorted.dedupped.indelrealigned.recal_data.post_recal_data.table'
POST_RECAL_DATA_NORMAL=$MASTER$POST_RECAL_DATA_PATH$SAMPLE_NORMAL$POST_RECAL_DATA_EXTENSION

java -jar $GATK_JARFILE \
-T BaseRecalibrator  \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_NORMAL \
-knownSites $SNPS \
-knownSites $INDELS \
-BQSR $RECAL_DATA_NORMAL \
-o $POST_RECAL_DATA_NORMAL


#Create Recalibration plot (AnalyzeCovariates.sh)
#Path to output recalibration plot
ANALYZECOVARIATES_PLOT_PATH='AnalyzeCovariatesRecalibrationPlots/'
ANALYZECOVARIATES_PLOT_EXTENSION='.sorted.dedupped.indelrealigned.recalibrationplot.pdf'
ANALYZECOVARIATES_PLOT_NORMAL=$MASTER$ANALYZECOVARIATES_PLOT_PATH$SAMPLE_NORMAL$ANALYZECOVARIATES_PLOT_EXTENSION

java -jar $GATK_JARFILE \
-T AnalyzeCovariates \
-R $REF_FASTA \
-before $RECAL_DATA_NORMAL \
-after $POST_RECAL_DATA_NORMAL \
-plots $ANALYZECOVARIATES_PLOT_NORMAL


#Recalibrate base quality score (PrintReads.sh)
#Path to output base quality recalibrated bam file
RECALIBRATED_OUTPUT_PATH='PrintReadsRecalibrated/'
RECALIBRATED_OUTPUT_EXTENSION='.sorted.dedupped.indelrealigned.recalibrated.bam'
RECALIBRATED_OUTPUT_NORMAL=$MASTER$RECALIBRATED_OUTPUT_PATH$SAMPLE_NORMAL$RECALIBRATED_OUTPUT_EXTENSION

java -jar $GATK_JARFILE \
-T PrintReads \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_NORMAL \
-BQSR $RECAL_DATA_NORMAL \
-o $RECALIBRATED_OUTPUT_NORMAL


#TUMOR
#Map read to reference genome (BWAmem.sh)
#Path to output bam file
OUTPUT_BWA_TUMOR=$MASTER$OUTPUT_BWA_PATH$SAMPLE_TUMOR$OUTPUT_BWA_EXTENSION

bwa mem \
-R '@RG\tID:foo\tSM:bar\tPL:Illumina' \
$REF_FASTA \
$INPUT_FASTQ_TUMOR_1 $INPUT_FASTQ_TUMOR_2 > \
$OUTPUT_BWA_TUMOR


#Sort mapped reads by coordinate (SortSam.sh)

cd $PICARD_PATH

#Path to coordinate sorted bam file
OUTPUT_SORTSAM_TUMOR=$MASTER$OUTPUT_SORTSAM_PATH$SAMPLE_TUMOR$OUTPUT_SORTSAM_EXTENSION

java -jar dist/picard.jar \
SortSam \
I=$OUTPUT_BWA_TUMOR \
O=$OUTPUT_SORTSAM_TUMOR \
SORT_ORDER=coordinate


#Mark duplicates (MarkDuplicates.sh)
cd $PICARD_PATH

#Path to dedupped output
OUTPUT_MARKDUPLICATES_TUMOR=$MASTER$OUTPUT_MARKDUPLICATES_PATH$SAMPLE_TUMOR$OUTPUT_MARKDUPLICATES_EXTENSION

#Path to metrics for deduplication
METRICS_TUMOR=$MASTER$METRICS_PATH$SAMPLE_TUMOR$METRICS_EXTENSION

java -jar dist/picard.jar \
MarkDuplicates \
CREATE_INDEX=true \
I=OUTPUT_SORTSAM_TUMOR \
O=$OUTPUT_MARKDUPLICATES_TUMOR \
M=$METRICS_TUMOR


#Create realignment targets (RealignerTargetCreator.sh)
#Path to output realignment target list
OUTPUT_REALIGNERTARGETCREATOR_TUMOR=$MASTER$OUTPUT_REALIGNERTARGETCREATOR_PATH$SAMPLE_TUMOR$OUTPUT_REALIGNERTARGETCREATOR_EXTENSION

java -jar $GATK_JARFILE \
-T RealignerTargetCreator \
-R $REF_FASTA \
-I $OUTPUT_MARKDUPLICATES_TUMOR \
-known $INDELS \
-o $OUTPUT_REALIGNERTARGETCREATOR_TUMOR


#Realign around indels (IndelRealigner.sh)
#Path to realigned bam file
OUTPUT_INDELREALIGNER_TUMOR=$MASTER$OUTPUT_INDELREALIGNER_PATH$SAMPLE_TUMOR$OUTPUT_INDELREALIGNER_EXTENSION

java -jar $GATK_JARFILE \
-T IndelRealigner \
-R $REF_FASTA \
-I $OUTPUT_MARKDUPLICATES_TUMOR \
-targetIntervals $OUTPUT_REALIGNERTARGETCREATOR_TUMOR \
-known $INDELS \
-o $OUTPUT_INDELREALIGNER_TUMOR


#Create base recalibration data table (BaseRecalibrator.sh)
#Path to output recalibration data table
RECAL_DATA_TUMOR=$MASTER$RECAL_DATA_PATH$SAMPLE_TUMOR$RECAL_DATA_EXTENSION

java -jar $GATK_JARFILE \
-T BaseRecalibrator \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_TUMOR \
-knownSites $SNPS \
-knownSites $INDELS \
-o $RECAL_DATA_TUMOR

#Second base recalibration data table for recalibration plot (BaseRecalibratorSecondPass.sh)
#Path to output recalibration data table
POST_RECAL_DATA_TUMOR=$MASTER$POST_RECAL_DATA_PATH$SAMPLE_TUMOR$POST_RECAL_DATA_EXTENSION

java -jar $GATK_JARFILE \
-T BaseRecalibrator  \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_TUMOR \
-knownSites $SNPS \
-knownSites $INDELS \
-BQSR $RECAL_DATA_TUMOR \
-o $POST_RECAL_DATA_TUMOR


#Create Recalibration plot (AnalyzeCovariates.sh)
#Path to output recalibration plot
ANALYZECOVARIATES_PLOT_TUMOR=$MASTER$ANALYZECOVARIATES_PLOT_PATH$SAMPLE_TUMOR$ANALYZECOVARIATES_PLOT_EXTENSION

java -jar $GATK_JARFILE \
-T AnalyzeCovariates \
-R $REF_FASTA \
-before $RECAL_DATA_TUMOR \
-after $POST_RECAL_DATA_TUMOR \
-plots $ANALYZECOVARIATES_PLOT_TUMOR


#Recalibrate base quality score (PrintReads.sh)
#Path to output base quality recalibrated bam file
RECALIBRATED_OUTPUT_TUMOR=$MASTER$RECALIBRATED_OUTPUT_PATH$SAMPLE_TUMOR$RECALIBRATED_OUTPUT_EXTENSION

java -jar $GATK_JARFILE \
-T PrintReads \
-R $REF_FASTA \
-I $OUTPUT_INDELREALIGNER_TUMOR \
-BQSR $RECAL_DATA_TUMOR \
-o $RECALIBRATED_OUTPUT_TUMOR


#Call variants (MuTect.sh)

#Path to output vcf
MUTECT_PATH='MuTect2/'
MUTECT_EXTENSION='.vcf'
MUTECT_OUTPUT=$MASTER$MUTECT_PATH$SAMPLE_TUMOR$MUTECT_EXTENSION

#run analysis
java -jar $GATK_JARFILE \
-T MuTect2 \
-R $REF_FASTA \
-I:tumor $RECALIBRATED_OUTPUT_TUMOR \
-I:normal $RECALIBRATED_OUTPUT_NORMAL \
--dbsnp $SNPS \
-nct $NCT \
-o $MUTECT_OUTPUT
