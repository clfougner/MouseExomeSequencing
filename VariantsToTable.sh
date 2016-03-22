#!/bin/bash

#ref: https://www.broadinstitute.org/gatk/guide/tooldocs/org_broadinstitute_gatk_tools_walkers_variantutils_VariantsToTable.php

#path to reference
REFERENCE='/data2/christian/mm9_fasta_2/mm9_fasta_2.fa'

#input
INPUT='/data2/christian/output/VEP_annotated/401_15_output_VEP.vcf'

#output
OUTPUT='/data2/christian/Output/Parsed/401_15_output_VEP_parsed.table'

cd /data2/christian/GenomeAnalysisTk3.5/
java -jar GenomeAnalysisTK.jar \
-R $REFERENCE
-T VariantsToTable \
-V $INPUT \
-F CHROM -F POS -F ID -F REF -F ALT -F QUAL -F FILTER -F INFO -F FORMAT -F TUMOR -F NORMAL \
-o $OUTPUT
