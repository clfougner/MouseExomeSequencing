#!/bin/bash

#download BWA: http://bio-bwa.sourceforge.net/
#ref: http://icb.med.cornell.edu/wiki/index.php/Elementolab/BWA_tutorial

#Unpack tarfile

cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/BWA/bwa-0.7.12/
make
export PATH=$PATH:/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/BWA/bwa-0.7.12/


#test install:
bwa