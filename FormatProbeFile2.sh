#!/bin/bash

INPUT_FILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/S0276129/OnlyCoordinatesAndID.txt'

OUTPUT_FILE='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/S0276129/OnlyCoordinatesAndID.gawk.txt'

gawk 'program' $INPUT_FILE > OUTPUT_FILE