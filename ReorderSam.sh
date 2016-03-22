 #!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to reference
REFERENCE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to input file to be reordered
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mgp.v3.indels.rsIDdbSNPv137.vcf'

#path to output/reordered file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SNPs_Reorder_outputs/2012-0612-snps+indels_FVBNJ_annotated.fixed.reordered.vcf'

#ref: www.broadinstitute.org/gatk/guide/article?id=1328

java -jar dist/picard.jar \
ReorderSam \
I=$INPUT \
O=$OUTPUT \
R=$REFERENCE \
CREATE_INDEX=TRUE

