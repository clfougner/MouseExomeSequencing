#!/bin/bash

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Frameworks/SnpEff/snpEff/

java -Xmx4g -jar snpEff.jar GRCm38.82 \
/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/401_15_output.vcf > \
401_15_output.ann.vcf

#note: this is using a different reference genome than the one that has been
#used for calling and aligment (NCBIM37.67), which is not available through
#snpEff