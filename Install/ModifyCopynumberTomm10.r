# Purpose: in order to use Sequenza on mm10, the "copynumber" package must be modified to allow for mm10. mm7, mm8 and mm9 are supported natively.
# Source:
# https://github.com/aroneklund/copynumber

# First, clone the repository
# cd /open/tmp/Christian/R/
# git clone https://github.com/Bioconductor-mirror/copynumber

# Make the following additions to the source code
# in R/aspcf.r: add "mm10" in line 33
# in R/multipcf.r: add "mm10" in line 31
# in R/pcf.r: add "mm10" in line 37
# in R/winsorsize.r: add "mm10" in line 52

# Download cytoband file for mm10
# http://hgdownload.cse.ucsc.edu/goldenpath/mm10/database/cytoBand.txt.gz

library("devtools")

# Set path to sysdata.rda file, found in the cloned repository. Cytoband data is stored in this file
pathToSysData<-"/open/tmp/Christian/R/copynumber/R/sysdata.rda"


a<-read.delim("/open/tmp/Christian/ReferenceFiles/mm10cytoBand.txt.gz", header=FALSE)
a2 <- a[a$V1 %in% c('chrX', 'chrY', paste0('chr', 1:19)), ]
a3 <- a2
a3$V1 <- factor(a3$V1)
a3$V4 <- factor(a3$V4)
rownames(a3) <- seq(1:nrow(a3))
mm10 <- a3

oldthings<-load(pathToSysData)
save(list=c(oldthings, "mm10"), file=pathToSysData)

# Install the modified copynumber package from the source code
install("/open/tmp/Christian/R/copynumber", repos=NULL, type="source")

