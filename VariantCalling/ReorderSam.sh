 #!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/Picard/

#path to reference
REFERENCE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'

#path to input file to be reordered
INPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/outputfile.vcf'

#path to output/reordered file
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/outputfile.reordersam.vcf'

#ref: www.broadinstitute.org/gatk/guide/article?id=1328

java -jar dist/picard.jar \
ReorderSam \
I=$INPUT \
O=$OUTPUT \
R=$REFERENCE \
CREATE_INDEX=false

