#!/bin/bash

#path to input file (dedupped)
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/DeduppedBams/422_15_2.sorted.dedupped.addedreadgroups.bam'

#path to and name of output file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/RealignerTargetCreator/422_15_2.sorted.dedupped.addedreadgroups.list'

#path to known indels
INDELS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.fixed.vcf'

#path to reference fasta
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to jarfile
JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'

java -jar $JARFILE \
-T RealignerTargetCreator \
-R $REF_FASTA \
-I $INPUT \
-known $INDELS \
-o $OUTPUT
