#!/usr/bin/env bash

for SAMPLE_TUMOR in 123_14_6 \
131_14_9 \
132_14_5 \
153_14_2 \
159_14_2 \
159_14_8 \
160_14_2 \
176_14_2 \
187_14_1 \
189_14_2 \
189_14_4 \
400_15_2 \
400_15_7 \
401_15_2 \
412_15_2 \
415_15_13 \
416_15_2 \
422_15_2
do

# #Sample numbers
# SAMPLE_NORMAL='123_14_8'
# #SAMPLE_TUMOR='123_14_6'

#Master path to output folder
MASTER='/home/christian/DMBA-induced/Output/'

#Path to SnpSift jarfile
SNPSIFT_JARFILE='/home/christian/Frameworks/SnpEff/snpEff/SnpSift.jar'

#Path to vcfEffOnePerLine.pl
ONE_PER_LINE='/home/christian/Frameworks/SnpEff/snpEff/scripts/vcfEffOnePerLine.pl'

# #Annotate with SnpEff (SnpEff.sh)
SNPEFF_PATH='SnpEffAnnotated/'
SNPEFF_EXTENSION='.annotated.vcf'
SNPEFF_OUTPUT=$MASTER$SNPEFF_PATH$SAMPLE_TUMOR$SNPEFF_EXTENSION

# #Filter annotated VCF for variants passing MuTect filters (SnpSiftForPass.sh)
SNPSIFT_PATH='FilterTests/OnePerLineAD10AF005RFModGrep/SnpSiftFiltered/'
SNPSIFT_EXTENSION='.modgrepAD10AF005FR.annotated.passfiltered.vcf'
SNPSIFT_OUTPUT=$MASTER$SNPSIFT_PATH$SAMPLE_TUMOR$SNPSIFT_EXTENSION

cat $SNPEFF_OUTPUT|$ONE_PER_LINE|java -jar $SNPSIFT_JARFILE \
filter "(FILTER='PASS') & (GEN[TUMOR].AD[1]>9) & (GEN[TUMOR].AF>0.049) & (GEN[TUMOR].ALT_F1R2>0) & (GEN[TUMOR].ALT_F2R1>0)" \
> $SNPSIFT_OUTPUT

#Extract pass filtered vcf to  text file (SnpSiftExtract.sh)
SNPEXTRACT_PATH='FilterTests/OnePerLineAD10AF005RFModGrep/SnpSiftExtracted/'
SNPEXTRACT_EXTENSION='.modgrepAD10AF005FR.annotated.passfiltered.extracted.txt'
SNPEXTRACT_OUTPUT=$MASTER$SNPEXTRACT_PATH$SAMPLE_TUMOR$SNPEXTRACT_EXTENSION

java -jar $SNPSIFT_JARFILE \
extractFields \
-s "," \
$SNPSIFT_OUTPUT \
'CHROM' 'POS' 'REF' 'ALT' 'ANN[*].GENE' 'GEN[TUMOR].AD' 'GEN[TUMOR].AF' 'GEN[NORMAL].AD' 'GEN[NORMAL].AF' 'ANN[*].IMPACT' \
'ANN[*].EFFECT' > $SNPEXTRACT_OUTPUT

#Remove modifier genes
GREP_PATH='FilterTests/OnePerLineAD10AF005RFModGrep/GrepOut/'
GREP_EXTENSION='.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.txt'
GREP_OUTPUT=$MASTER$GREP_PATH$SAMPLE_TUMOR$GREP_EXTENSION

cat $SNPEXTRACT_OUTPUT | grep -v 'MODIFIER' > $GREP_OUTPUT

#Remove duplicates

REMOVE_DUPLICATES_PATH='/home/christian/Scripts/All/OnePerLineRedo/RemoveDuplicateVariants.r'
REMOVE_DUPLICATES_OUTPUT_PATH='FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/'
REMOVE_DUPLICATES_OUTPUT_EXTENSION='.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt'
REMOVE_DUPLICATES_OUTPUT=$MASTER$REMOVE_DUPLICATES_OUTPUT_PATH$SAMPLE_TUMOR$REMOVE_DUPLICATES_OUTPUT_EXTENSION

#R script needs to be executable, uncomment next line first time.
#chmod +x $REMOVE_DUPLICATES_PATH

$REMOVE_DUPLICATES_PATH $GREP_OUTPUT $MASTER $SAMPLE_TUMOR

#wc -l $REMOVE_DUPLICATES_OUTPUT

REMOVE_DUPLICATES_GENES_PATH='/home/christian/Scripts/All/OnePerLineRedo/RemoveDuplicateGenes.r'
REMOVE_DUPLICATES_GENES_OUTPUT_PATH='FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/'
REMOVE_DUPLICATES_GENES_OUTPUT_EXTENSION='.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt'
REMOVE_DUPLICATES_GENES_OUTPUT=$MASTER$REMOVE_DUPLICATES_GENES_OUTPUT_PATH$SAMPLE_TUMOR$REMOVE_DUPLICATES_GENES_OUTPUT_EXTENSION

$REMOVE_DUPLICATES_GENES_PATH $REMOVE_DUPLICATES_OUTPUT $MASTER $SAMPLE_TUMOR

wc -l $REMOVE_DUPLICATES_GENES_OUTPUT



done 

