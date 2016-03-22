#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to reference FASTA
FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to output
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.dict'

java -jar dist/picard.jar \
CreateSequenceDictionary \
REFERENCE=$FASTA \
OUTPUT=$OUTPUT

#ref:https://www.broadinstitute.org/gatk/guide/article?id=2798
#ref: https://github.com/broadinstitute/picard :remember dist/picard.jar, else "Error:unable to access jarfile picard.jar"