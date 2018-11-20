#!/bin/bash

#Download known SNP file
#wget -O ./mm10.FVBN.SNPs.dbSNP142.vcf.gz ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.snps.dbSNP142.vcf.gz

#Unzip known SNP file
#gunzip ./mm10.FVBN.SNPs.dbSNP142.vcf.gz

#Path to input file
INPUT='/path/to/mm10.FVBN.SNPs.dbSNP142.vcf'

#Path to output file
OUTPUT='/path/to/mm10.FVBN.SNPs.unordered.vcf'

#Format known SNP file be compatible with mm10.fa
gawk '{ if($0 !~ /^#/) print "chr"$0; else if(match($0,/(##contig=<ID=)(.*)/,m)) print m[1]"chr"m[2]; else print $0 }' $INPUT > $OUTPUT


#change directory to Picard folder
cd /path/to/Picard/

#path to input file to be reordered
SORT_INPUT='/path/to/mm10.FVBN.SNPs.unordered.vcf'

#path to output/reordered file
SORT_OUTPUT='/path/to/mm10.FVBN.SNPs.vcf'

#ref: www.broadinstitute.org/gatk/guide/article?id=1328

java -jar dist/picard.jar \
SortVcf \
I=$SORT_INPUT \
O=$SORT_OUTPUT

#Thanks to John Longinotto for help with this issue: https://www.biostars.org/p/182917/#183000
