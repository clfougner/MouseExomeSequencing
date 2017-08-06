counts<-read.table("~/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/TrinucleotideCountsOnlyCT.txt")

# Find proportion of cytosines+guanine to adenosine+thymine
allCytosines<-sum(counts[c(1:4, 9:12, 17:20, 25:28), 2])
totalNucleotides<-sum(as.numeric((counts[, 2])))
cytosineProportion<-allCytosines/totalNucleotides

# Find proportion of thymine+adenosine to all cytosine+guanine
allThymines<-sum(counts[c(5:8, 13:16, 21:24, 29:32), 2])
thymineProportion<-allThymines/totalNucleotides

# Proportion of NTG thymine nucleotides relative to all thymines
NTG<-sum(counts[c(7, 15, 23, 31), 2])
NTGdivNTN<-NTG/allThymines

# Proportion of NCA adenosine nucleotides relative to all thymines
NCA<-sum(counts[c(1, 9, 17, 25), 2])
NCAdivNCN<-NCA/allCytosines


# N[T>A]G hypothesis
# H0 N[T>A]G mutations occur as frequently as the proportion of NTG trinucleotides in the genome
# Expected: N[T>A]G occur as frequently as NTG occurs in the genome relative to NTN
expected<-NTGdivNTN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
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
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)


# N[T>C]G hypothesis
# H0 N[T>C]G mutations occur as frequently as the proportion of NTG trinucleotides in the genome
# Expected: N[T>C]G occur as frequently as NTG occurs in the genome relative to NTN
expected<-NTGdivNTN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
# H1 N[T>C]G mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[T>C]G/N[T>C]N for each individual observation
observedNTCG<-sigs.input[, c("A[T>C]G", "C[T>C]G", "T[T>C]G", "G[T>C]G")]
observedNTCN<-sigs.input[,65:80]
observed<-c()
for (i in 1:length(observedNTCG[,1])){
  current<-sum(observedNTCG[i, ])/sum(observedNTCN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)


# N[T>G]G hypothesis
# H0 N[T>G]G mutations occur as frequently as the proportion of NTG trinucleotides in the genome
# Expected: N[T>G]G occur as frequently as NTG occurs in the genome relative to NTN
expected<-NTGdivNTN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
# H1 N[T>G]G mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[T>G]G/N[T>G]N for each individual observation
observedNTGG<-sigs.input[, c("A[T>G]G", "C[T>G]G", "T[T>G]G", "G[T>G]G")]
observedNTGN<-sigs.input[,81:96]
observed<-c()
for (i in 1:length(observedNTGG[,1])){
  current<-sum(observedNTGG[i, ])/sum(observedNTGN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)


# N[C>A]A hypothesis
# H0 N[C>A]A mutations occur as frequently as the proportion of NCA trinucleotides in the genome
# Expected: N[C>A]A occur as frequently as NCA occurs in the genome relative to NCN
expected<-NCAdivNCN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
# H1 N[C>A]A mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[C>A]A/N[C>A]N for each individual observation
observedNCAA<-sigs.input[, c("A[C>A]A", "C[C>A]A", "T[C>A]A", "G[C>A]A")]
observedNCAN<-sigs.input[,1:16]
observed<-c()
for (i in 1:length(observedNCAA[,1])){
  current<-sum(observedNCAA[i, ])/sum(observedNCAN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)


# N[C>G]A hypothesis
# H0 N[C>G]A mutations occur as frequently as the proportion of NCA trinucleotides in the genome
# Expected: N[C>G]A occur as frequently as NCA occurs in the genome relative to NCN
expected<-NCAdivNCN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
# H1 N[C>G]A mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[C>G]A/N[C>G]N for each individual observation
observedNCGA<-sigs.input[, c("A[C>G]A", "C[C>G]A", "T[C>G]A", "G[C>G]A")]
observedNCGN<-sigs.input[,17:32]
observed<-c()
for (i in 1:length(observedNCGA[,1])){
  current<-sum(observedNCGA[i, ])/sum(observedNCGN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)


# N[C>T]A hypothesis
# H0 N[C>T]A mutations occur as frequently as the proportion of NCA trinucleotides in the genome
# Expected: N[C>T]A occur as frequently as NCA occurs in the genome relative to NCN
expected<-NCAdivNCN

# From deconstructSigs, get sigs.input<-mut.to.sigs.input (SignaturesPatterns.r)
# H1 N[C>T]A mutations occur more frequently then the proportion of NTG trinucleotides in the genome
# Observed N[C>T]A/N[C>T]N for each individual observation
observedNCTA<-sigs.input[, c("A[C>T]A", "C[C>T]A", "T[C>T]A", "G[C>T]A")]
observedNCTN<-sigs.input[,33:48]
observed<-c()
for (i in 1:length(observedNCTA[,1])){
  current<-sum(observedNCTA[i, ])/sum(observedNCTN[i, ])
  observed<-c(observed, current)
}

# Perform the t-test
t.test(x=observed, alternative = "greater", mu = expected, paired = FALSE)
