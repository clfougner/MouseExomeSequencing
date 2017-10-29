inpt <- read.table(file = "/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/nMutsImmuneScore.txt", sep = "\t", header = TRUE)
linReg <- lm(nMutsModLow ~ ImmuneScore, data = inpt, na.action = "na.omit")
print(summary(linReg))

inpt <- inpt[-c(2,3),]

linReg <- lm(nMutsModLow ~ ImmuneScore, data = inpt, na.action = "na.omit")
