#!/bin/bash

#Path to tumor bam file
TUMORBAM='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/PrintReadsRecalibrated/422_15_2.sorted.dedupped.indelrealigned.addedreadgroups.recalibrated.bam'

#Path to normal Bam file
NORMALBAM='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/PrintReadsRecalibrated/422_15_11.sorted.dedupped.indelrealigned.addedreadgroups.recalibrated.bam'

#Path to output vcf
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/MuTect2/422_15_2.vcf'

#Path to reference fasta file
REF_FASTA='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#Path to reference SNP file
SNPS='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.FVBN.SNPs.vcf'

#Path to GATK jarfile
GATK_JARFILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar'

#run analysis
java -jar $GATK_JARFILE \
-T MuTect2 \
-R $REF_FASTA \
-I:tumor $TUMORBAM \
-I:normal $NORMALBAM \
--dbsnp $SNPS \
-nct 2 \
-o $OUTPUT