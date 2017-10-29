table <- read.table(file = "/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/tblForFisher.txt", sep = "\t", header = TRUE)

# For only genes with mutation frequency above 2%
#table<-table[1:38,]

TCGAcount <- 817
DMBAcount <- 18

for (i in 1:length(table$nMutTCGA)) {
  #note: following column names are "incorrect" because of issues with excel formattin
  currentTCGA <- table[i, "nMutTCGA"]
  currentDMBA <- table[i, "nMutDMBA"]
  
  df <- data.frame(x = c(currentTCGA, (TCGAcount - currentTCGA)), y = c(currentDMBA, (DMBAcount - currentDMBA)))
  

  table[i,3] <- fisher.test(df, alternative = "two.sided")[1]
}

table[,4] <- p.adjust(table[,3], method = "BH")

`colnames<-`(table, c("nMutTCGA","nMutDMBA","p.value","p.adjusted"))

write.table(table, file = "/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/FisherExactmm10.txt", sep = "\t", quote = F)
