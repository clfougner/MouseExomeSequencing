#!/bin/bash

#Cutadapted inputs
FORWARD='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/CutadaptOutput/TN1511D0825_1.cutadapt.fastq'
REVERSE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/CutadaptOutput/TN1511D0825_2.cutadapt.fastq'

#Trimmed outputs
OUTPUT_FORWARD='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/Sickle/TN1511D0825_1.cutadapt.trim.fastq'
OUTPUT_REVERSE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/Sickle/TN1511D0825_2.cutadapt.trim.fastq'
OUTPUT_SINGLE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/Sickle/TN1511D0825.cutadapt.trimsingle.fastq'

#Qual threshold: threshold for trimming based on average quality in a window (default=20)
QUAL=20

#Length threshold: threshold to keep a read based on length after trimming (default=20)
LENGTH=20

#Path to Sickle framework
SICKLE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/sickle-master/sickle'

# fastq low quality trimming
$SICKLE pe \
-t sanger \
-g \
-q $QUAL \
-l $LENGTH \
-f $FORWARD \
-r $REVERSE \
-o $OUTPUT_FORWARD \
-p $OUTPUT_REVERSE \
-s TN1511D0795_1.trim.single.fastq.gz
