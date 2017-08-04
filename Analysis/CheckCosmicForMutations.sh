#!/bin/bash

GENE=-"Kras"
AMINO_ACID="g12a"
COSMIC="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/v82/CosmicMutantExport.tsv"

cat $COSMIC | grep -i -w $GENE | grep -i $AMINO_ACID | wc -l