
#library(stringr)
#allMutations<-read.table(file="~/Documents/Forskerlinja/Forskerlinjeoppgaven/Supplementary/CosmicHomologsWorksheet.txt", sep="\t", header=TRUE)

#COSMIC<-read.table(file="~/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/v82/CosmicMutantExport.tsv", sep="\t", header=TRUE)
#COSMIC<-data.frame(COSMIC$Gene.name, COSMIC$Primary.site, COSMIC$Mutation.CDS, COSMIC$Mutation.AA, COSMIC$Mutation.genome.position, COSMIC$Mutation.Description, COSMIC$Mutation.zygosity)

#for (mut in 1:length(allMutations$sample)){

for (mut in 135){
  
  if (is.na(allMutations[mut, "queried_aa"])){
    next
  }
  
  currentGene<-allMutations[mut, "queried_gene"]
  
  cosmicMutsCurrent<-grep(pattern=currentGene, x=COSMIC$COSMIC.Gene.name, ignore.case = TRUE)
  cosmicMutsCurrentDataFrame<-COSMIC[cosmicMutsCurrent, ]
  
  numberOfMutationsForGene<-length(cosmicMutsCurrentDataFrame$COSMIC.Gene.name)
  print(paste("There are", numberOfMutationsForGene, "mutations in the gene", currentGene))
  


  # Mouse amino acid codon
  currentMutation<-allMutations[mut, "aa_change_shorthand"]
  
  # Human amino acid subsitution
  # 1. Get first three characters from aa_change_shorthand
  startHumanSubstitution<-substr(x = currentMutation, 1, 3)
  
  # 2. Get queried_aa
  queriedCodon<-allMutations[mut, "queried_aa"]
  
  # 3. Get final character from aa_change_shorthand
  lengthCurrentMutation<-nchar(as.character(currentMutation))
  finalTwoChars<-substr(currentMutation, (lengthCurrentMutation-1), lengthCurrentMutation)
  if (finalTwoChars == "fs"){
    endHumanSubstitution<-"fs"
  }
  
  if (finalTwoChars != "fs"){
    endHumanSubstitution<-substr(currentMutation, lengthCurrentMutation, lengthCurrentMutation)
  }
  
  # This is the human codon to query in the COSMIC database
  queriedCodonSubstitution<-paste(startHumanSubstitution, queriedCodon, endHumanSubstitution, sep="")
  
  cosmicExactMatchesCurrent<-grep(pattern=queriedCodonSubstitution, x=cosmicMutsCurrentDataFrame$COSMIC.Mutation.AA)
  numberOfExactMatchesCurrent<-length(cosmicExactMatchesCurrent)
  print(paste("There are", numberOfExactMatchesCurrent, "exact matches for", queriedCodonSubstitution, "in the gene", currentGene))
  exactMatchesCurrentDataFrame<-COSMIC[cosmicExactMatchesCurrent, ]
  exactMatchesInBreastCurrent<-grep(pattern="breast", x=exactMatchesCurrentDataFrame$COSMIC.Primary.site)
  numberOfExactMatchesInBreastCurrent<-length(exactMatchesInBreastCurrent)
  print(paste("Of these", numberOfExactMatchesCurrent, queriedCodonSubstitution, "mutations,", numberOfExactMatchesInBreastCurrent, "are found in breast tumors", sep=" "))
  
  
  # Find number of mutations in COSMIC for a given codon
  cosmicMatchesInCurrentCodon<-grep(pattern=queriedCodon, x=str_extract_all(cosmicMutsCurrentDataFrame$COSMIC.Mutation.AA, "[0-9]+"))
  numberOfMutationsInCurrentCodonInCurrentGene<-length(cosmicMatchesInCurrentCodon)
  print(paste("There are", numberOfMutationsInCurrentCodonInCurrentGene, "mutations in codon", queriedCodon, "in the gene", currentGene))
  matchesInCurrentCodonDataFrame<-COSMIC[cosmicMatchesInCurrentCodon, ]
  matchesInCurrentCodonInBreast<-grep(pattern="breast", x=matchesInCurrentCodonDataFrame$COSMIC.Primary.site)
  numberOfMatchesInCurrentCodonInBreast<-length(matchesInCurrentCodonInBreast)
  print(paste("Of the", numberOfMutationsInCurrentCodonInCurrentGene, "mutations in codon", queriedCodon, "in the gene", currentGene, "-", numberOfMatchesInCurrentCodonInBreast, "are found in breast tumors"))
  
  # 
  
  
  
  
    
}