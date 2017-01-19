table<-read.table(file="/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/tblForFisher.txt", sep="\t")

TCGAcount<-817
DMBAcount<-18



for (i in 1:length(table$nMutTCGA)){
  #note: following column names are "incorrect" because of issues with excel formattin
  currentTCGA<-table[i, "nMutTCGA"]
  currentDMBA<-table[i, "nMutDMBA"]
  
  df<-data.frame(x=c(currentTCGA, (TCGAcount-currentTCGA)), y=c(currentDMBA, (DMBAcount-currentDMBA)))
  

  table[i,3]<-fisher.test(df, alternative="two.sided")[1]
}

write.table(table, file="/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FisherExact.txt", sep="\t", quote=F)
