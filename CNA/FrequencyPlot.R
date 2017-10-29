# First run AmpDelHeatmapAllChroms.R

chroms <- c()
middleChromPositions <- c()


for (i in 1:length(allDF$S123_14_6)){
  
  if (i == length(allDF$S123_14_6)){
    positionMidpoint <- as.numeric(row.names(allDF)[i])
  }
  
  if (i < length(allDF$S123_14_6)){
    aggregatePositionStart <- as.numeric(row.names(allDF)[i])
    aggregatePositionEnd <- as.numeric(row.names(allDF)[i + 1])
    positionMidpoint <- median(c(aggregatePositionStart, aggregatePositionEnd))
  }

  
  for (n in 1:length(chromLengths$V1)){
    if (n == 1){
      chromStart <- 0
      chromEnd <- chromLengths$aggregate[n]
    }
    
    if (n > 1){
      chromStart <-chromLengths$aggregate[n-1] + 1
      chromEnd <- chromLengths$aggregate[n]
    }
    
    if (chromStart < positionMidpoint && positionMidpoint < chromEnd ){
      if (n == 1){
        currentPosition <- positionMidpoint
      }
      
      if (n > 1){
        currentPosition <- positionMidpoint - chromLengths$aggregate[n-1]
      }
      
      chroms <- c(chroms, n)
      middleChromPositions <- c(middleChromPositions, currentPosition)
    }
  }
}

allDF <- cbind(chrom = chroms, pos <- middleChromPositions, allDF)



pcfSegs <- pcf(data = allDF, gamma = 12, return.est = TRUE, verbose = FALSE)
plotFreq(segments = pcfSegs, thres.gain = 0.2, thres.loss = -0.1)

