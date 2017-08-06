
#library(stringr)
#allMutations<-read.table(file="~/Documents/Forskerlinja/Forskerlinjeoppgaven/Supplementary/CosmicHomologsWorksheet.txt", sep="\t", header=TRUE)

#COSMIC<-read.table(file="~/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/v82/CosmicMutantExport.tsv", sep="\t", header=TRUE)
#COSMIC<-data.frame(COSMIC$Gene.name, COSMIC$Primary.site, COSMIC$Mutation.CDS, COSMIC$Mutation.AA, COSMIC$Mutation.genome.position, COSMIC$Mutation.Description, COSMIC$Mutation.zygosity)

outputDataFrame<-data.frame(sample=allMutations$sample, gene=allMutations$gene, queried_gene=allMutations$queried_gene, aa_change=allMutations$aa_change, aa_change_shorthand=allMutations$aa_change_shorthand, queried_aa=allMutations$queried_aa, aa_conserved=allMutations$aa_conserved, human_aa_if_not_conserved=allMutations$human_aa_if_not_conserved, location=allMutations$location, ref=allMutations$ref, alt=allMutations$alt, nucleotide_change=allMutations$nucleotide_change, cosmic_exact_matches=NA, cosmic_exact_matches_in_breast=NA, cosmic_matches_in_codon=NA, cosmic_matches_in_codon_in_breast=NA, cosmic_matches_in_10_AA_window=NA, cosmic_mutations_in_gene=NA, cosmic_mutations_in_gene_in_breast=NA)

#for (mut in 1:length(allMutations$sample)){

for (mut in 135){
  
  if (is.na(allMutations[mut, "queried_aa"])){
    next
  }
  ##############################################
  # Finder number of mutations in the given gene
  ##############################################
  
  currentGene<-allMutations[mut, "queried_gene"]
  
  cosmicMutsCurrent<-grep(pattern=paste("^", currentGene, "$", sep=""), x=COSMIC$COSMIC.Gene.name)
  cosmicMutsCurrentDataFrame<-COSMIC[cosmicMutsCurrent, ]
  
  numberOfMutationsForGene<-length(cosmicMutsCurrentDataFrame$COSMIC.Gene.name)
  print(paste("There are", numberOfMutationsForGene, "mutations in the gene", currentGene))
  
  geneMatchesInBreast<-grep(pattern=paste("^breast$", sep=""), x=cosmicMutsCurrentDataFrame$COSMIC.Primary.site)
  geneMatchesInBreastDataFrame<-cosmicMutsCurrentDataFrame[geneMatchesInBreast, ]
  numberOfGeneMatchesInBreast<-length(geneMatchesInBreastDataFrame$COSMIC.Gene.name)
  print(paste("Of the", numberOfMutationsForGene, "mutations in the", currentGene, "gene,", numberOfGeneMatchesInBreast, "are found in breast cancers"))
  

  ##############################
  # Find number of exact matches
  ##############################
  
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
  
  
  ######################################################
  # Find number of mutations in COSMIC for a given codon
  ######################################################
  cosmicMatchesInCurrentCodon<-grep(pattern=paste("^", queriedCodon, "$", sep=""), x=str_extract_all(cosmicMutsCurrentDataFrame$COSMIC.Mutation.AA, "[0-9]+"))
  numberOfMutationsInCurrentCodonInCurrentGene<-length(cosmicMatchesInCurrentCodon)
  print(paste("There are", numberOfMutationsInCurrentCodonInCurrentGene, "mutations in codon", queriedCodon, "in the gene", currentGene))
  matchesInCurrentCodonDataFrame<-COSMIC[cosmicMatchesInCurrentCodon, ]
  matchesInCurrentCodonInBreast<-grep(pattern="breast", x=matchesInCurrentCodonDataFrame$COSMIC.Primary.site)
  numberOfMatchesInCurrentCodonInBreast<-length(matchesInCurrentCodonInBreast)
  print(paste("Of the", numberOfMutationsInCurrentCodonInCurrentGene, "mutations in codon", queriedCodon, "in the gene", currentGene, "-", numberOfMatchesInCurrentCodonInBreast, "are found in breast tumors"))
  
  
  ###############################################
  # Find number of mutations in a 10 codon window
  ###############################################
  cosmicMatchesIn10AAWindow<-as.integer(c())
  for (i in (queriedCodon-10):(queriedCodon+10)){
    if (i == queriedCodon){
      next
    }
      currentMatchInLoop<-grep(pattern=paste("^", i, "$", sep=""), x=str_extract_all(cosmicMutsCurrentDataFrame$COSMIC.Mutation.AA, "[0-9]+"))
      cosmicMatchesIn10AAWindow<-as.integer(c(cosmicMatchesIn10AAWindow, currentMatchInLoop))
      
  }
  
  numberOfCosmicMatchesIn10AAWindow<-length(cosmicMatchesIn10AAWindow)
  print(paste("There are", numberOfCosmicMatchesIn10AAWindow, "mutations in a 10 amino acid range of the queried codon (queried codon not included)"))
  
    
}