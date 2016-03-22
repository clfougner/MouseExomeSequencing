#!/bin/bash

#install picard
#Download homebrew
#ref: brew.sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ant

#clone Picard Repo:
#ref: git clone git@github.com:broadinstitute/picard.git
cd /Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Picard/

#Download htsjdk .zip file, and unpack. Rename folder to "htsjdk". Place folder in Picard folder.

#Build
ant

