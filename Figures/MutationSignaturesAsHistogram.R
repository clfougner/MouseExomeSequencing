library("ggplot2")

dataFile <- read.table(file = "~/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/SignatureProportions.txt", sep = "\t", col.names = c("sample", "signature", "proportion"))

dataFile[, "proportion"] <- dataFile[, "proportion"]/100
              
sampleNames <- c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

for (i in sampleNames) {
  row <- grep(pattern = i, x = dataFile$sample)
  tot <- sum(dataFile[row, "proportion"])
  missing <- 1 - tot
  toAdd <- data.frame(sample = i, signature = "Error", proportion = missing)
  dataFile <- rbind(dataFile, toAdd)
}

dataFile$signature <- factor(dataFile$signature, levels = c("Signature 4", "Signature 22", "Signature 25", "Error"))

plotdata <- ggplot(dataFile, aes(x = factor(sample), y = proportion, fill = factor(signature)), color = factor(signature))

chart <- plotdata + stat_summary(fun.y = mean,position = "stack", geom = "bar") +
  theme(axis.title.x = element_blank(),
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_text(angle = 90),
        panel.background = element_rect(fill = "white"),
        legend.title = element_blank()) +
  labs(y = 'Weighting of signature') +
  geom_col(position = position_stack(reverse = TRUE)) + 
  scale_fill_manual(values = c("Signature 4" = "#CC6666","Signature 22" = "#9999CC", "Signature 25" = "#66CC99",  "Error" = "grey"), breaks = c("Signature 4", "Signature 22", "Signature 25", "Error"))

print(chart)

