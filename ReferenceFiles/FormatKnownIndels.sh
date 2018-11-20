#!/bin/bash

#Download known indel file
#wget -O ./mm10.FVBN.INDELS.dbSNP142.vcf.gz ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.indels.dbSNP142.normed.vcf.gz

#Unzip known indel file
#gunzip ./mm10.FVBN.INDELS.dbSNP142.vcf.gz

#Path to input file
INPUT='/path/to/FVBN.INDELS.dbSNP142.vcf.gz'

#Path to output file
OUTPUT='/path/to/mm10.INDELS.vcf'

#Format known indel file be compatible with mm10.fa
gawk '{ if($0 !~ /^#/) print "chr"$0; else if(match($0,/(##contig=<ID=)(.*)/,m)) print m[1]"chr"m[2]; else print $0 }' $INPUT > $OUTPUT


#Thanks to John Longinotto for help with this issue: https://www.biostars.org/p/182917/#183000
