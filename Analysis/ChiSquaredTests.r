# Read table of mutation frequencies
df<-read.table("/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FrequencyTable.txt", sep="\t", header=TRUE)

#Number of samples
nSamples<-18


# Find nucleotide counts in mm10 reference genome
# cd /open/tmp/Christian/ReferenceFiles/
# grep -o "T" mm10.fa | wc -l
ACount<-427456346
aCount<-345823800
CCount<-299623606
cCount<-253024277
GCount<-299552717
gCount<-253137432
TCount<-427635170
tCount<-346530271

# Find total number of nucleotides in reference genome
totalNucleotides<-sum(ACount, aCount, CCount, cCount, GCount, gCount, TCount, tCount)

# Find total number of A+T and C+G nucleotides in reference genome
allAT<-sum(ACount, aCount,TCount, tCount)
allCG<-sum(CCount, cCount, GCount, gCount)

# Find proportion of A+T and C+G nucleotides in reference genome
proportionATInGenome<-allAT/totalNucleotides
proportionCGInGenome<-allCG/totalNucleotides

# Find expected proportion of mutations from A+T and C+G 
expectedProportionATMutations<-proportionATInGenome/3
expectedProportionCGMutations<-proportionCGInGenome/3


# Count total number of mutations in each sample and place in vector sampleMutationCount
sampleMutationCount<-c()
for (i in 1:nSamples){
  sampleMutationCount<-c(sampleMutationCount, rowSums(df[i,]))
}

# Find total number of mutations in all samples
mutationSum<-sum(sampleMutationCount)


# Place mutation counts in vector dfToVector
dfToVector<-c()
for (i in 1:nSamples){
  for (n in 1:6){
    dfToVector<-c(dfToVector, df[i,n])
  }
}


# Find expected proportion of mutations for the given mutation class in the given sample (given total number of mutations in the sample), for the entire cohort
allExpectations<-c()
for (i in 1:nSamples){
  for (n in 1:3){
   allExpectations<-c(allExpectations, (sampleMutationCount[i]*expectedProportionCGMutations/mutationSum)) 
  }
  
  for (n in 1:3){
    allExpectations<-c(allExpectations, (sampleMutationCount[i]*expectedProportionATMutations/mutationSum)) 
  }
}

# Perform chi-squared test
test<-chisq.test(dfToVector, p=allExpectations)
