counts<-read.table("~/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/TrinucleotideCountsMouseGenome.txt")

# Find proportion of cytosines to all nucleotides in the genome
allCytosines<-sum(counts[c(5:8, 21:24, 37:40, 53:56), 2])
totalNucleotides<-sum(as.numeric((counts[, 2])))
cytosineProportion<-allCytosines/totalNucleotides

# Find proportion of thymines to all nucleotides in genome
allThymines<-sum(counts[c(13:16, 29:32, 45:48, 61:64), 2])
thymineProportion<-allThymines/totalNucleotides

# Proportion of NTG thymine nucleotides relative to all thymines
NTG<-sum(counts[c(15, 31, 47, 63), 2])
NTGdivNTN<-NTG/allThymines

# Proportion of NCA adenosine nucleotides relative to all thymines
NCA<-sum(counts[c(5, 21, 37, 53), 2])
NCAdivNCN<-NCA/allCytosines

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)

# H0 N[T>A]G mutations occur as frequently as the proportion of NTG trinucleotides in the genome
# Expected: N[T>A]G occur as frequently as NTG occurs in the genome relative to NTN
expected<-NTGdivNTN

# H1 N[T>A]G mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[T>A]G/N[T>A]N for each individual observation
observedNTAG<-sigs.input[, c("A[T>A]G", "C[T>A]G", "T[T>A]G", "G[T>A]G")]
observedNTAN<-sigs.input[,49:64]
observed<-c()
for (i in 1:length(observedNTAG[,1])){
  current<-sum(observedNTAG[i, ])/sum(observedNTAN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "two.sided", mu = expected, paired = FALSE)
