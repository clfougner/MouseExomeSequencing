#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to reference
REFERENCE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.dict'

#path to input file to be reordered
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.vcf'

#path to output/reordered file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/output.vcf'

#ref: www.broadinstitute.org/gatk/guide/article?id=1328

java -jar dist/picard.jar \
SortVcf \
I=$INPUT \
O=$OUTPUT \
SEQUENCE_DICTIONARY=$REFERENCE 

#NOTE: delete index file in order to make the reordered file work with Mutect2
