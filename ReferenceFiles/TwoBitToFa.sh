#!/bin/bash

#path to .2bit file
TWOBIT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.2bit'

#path to output file (fasta)
OUTPUT='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10.fa'


twoBitToFa \
$TWOBIT \
$OUTPUT


#Setup

#1) Downloaded twoBitToFa for macOSX.x86_64 from:
#http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/

#2) Downloaded mm9.2bit from:
#http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/

#3)
#chmod +x twoBitToFa
#. /twoBitToFa

#4) Copied executable twoBitToFa file to $PATH in:
#usr/local/bin