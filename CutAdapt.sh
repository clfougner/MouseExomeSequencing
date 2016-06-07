#!/bin/bash

INPUT_FILE_1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_1.fastq'
INPUT_FILE_2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FastQInput/TN1511D0826/TN1511D0826_2.fastq'

OUTPUT_FILE_1='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/CutadaptOutput/TN1511D0826_1.cutadapt.fastq'
OUTPUT_FILE_2='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/CutadaptOutput/TN1511D0826_2.cutadapt.fastq'

LEFT_ADAPTER_SEQUENCE='GATCGGAAGAGCACACGTCTGAACTCCAGTCAC'
RIGHT_ADAPTER_SEQUENCE='ATCTCGTATGCCGTCTTCTGCTTG'
INDEX_SEQUENCE='CGCATACA'


# adapt trimming
cutadapt \
-a $LEFT_ADAPTER_SEQUENCE$INDEX_SEQUENCE$RIGHT_ADAPTER_SEQUENCE \
-A $LEFT_ADAPTER_SEQUENCE$INDEX_SEQUENCE$RIGHT_ADAPTER_SEQUENCE \
-o $OUTPUT_FILE_1 \
-p $OUTPUT_FILE_2 \
$INPUT_FILE_1 $INPUT_FILE_2 > TN1511D0826_1.cutadapt.log