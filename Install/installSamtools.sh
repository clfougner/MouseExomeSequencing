#!/bin/bash

#installing samtools
#ref: http://www.htslib.org/download/


cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/samtools1.3/
make
make prefix=/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ install

export PATH=/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/bin:$PATH

