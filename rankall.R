rankall <- function(outcome = "heart attack", rank = 1) {
  #set working directory
  setwd("C:/R/r-coursera/programming_assignment3/")

  #fix these numbers in colClasses!!! only want the 3 outcomes imported as numeric
  allData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  #step2 check if valid:
  if (outcome %in% c("heart attack", "heart failure", "pneumonia") == FALSE) {
    stop("invalid outcome")}
  else { #(all below)
    colName <- ""
    if (outcome == "heart attack") {
      colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" } #is column no. 11
    else if (outcome == "heart failure") {
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" } #is column no. 17
    else if (outcome == "pneumonia") {
      colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"  } #is column no. 23
 
  
  #can these things live outside the loop??
    #initialize the winners data frame
    winnerDF <- data.frame(matrix(ncol = 2, nrow = 0))
    colnames(winnerDF) <- c("state", "hospital")

  #put the chosen outcome column into numeric form
  suppressWarnings(allData[, colName] <- as.numeric(allData[, colName]))

  # put that specific outcome into a vector w/ only a specific state
      stateOutcomeData <- allData[, c("State", "Hospital.Name", colName)]
      names(stateOutcomeData) <- c("state", "hospital", "outcome")
  # keep only complete cases
      stateOutcomeData <- stateOutcomeData[complete.cases(stateOutcomeData),]
  #    print("stateOutcomeData")
  #    print(stateOutcomeData)

  # get all the states
      states <- unique(stateOutcomeData[,"state"])
      states <- sort(states)
  #    print("states")
  #    print(states)

  #next problem will require remove NAs at this point? 

  if (rank == "worst") {
  
    #Need to loop through each state in states
      #vector of unique states in the vector
      # for each state in states {do the stuff} 
      # append to winner df
    # and add the resulting winner to new data frame

    #begin the loop for "worst" rank
    for (astate in states) {

      # put that specific outcome into a vector w/ only a specific state
       # not using stateOutcomeData <- allData[allData$State == state , c("State", "Hospital.Name", colName)]
        # rename "State" "Hospital.Name" and colName
       # print(stateOutcomeData) # looks good

### getting error when I try to subset/order/whatever i'm trying to do
         aStateOutcomeData <- stateOutcomeData[ which(stateOutcomeData$state == astate), c("state", "hospital", "outcome")]
        # order by outcome ascending then by Hospital Name (2)
            # might have to rename "outcome" to colName
         aStateOutcomeData <- aStateOutcomeData[order(aStateOutcomeData[,"outcome"], rev(aStateOutcomeData[,2]), decreasing = TRUE), ]
       # print("head aStateOutcomeData 1, c(1,2)")
        #print(head(aStateOutcomeData[1,c(1,2)]))
         #add winner to winner df
       #  print("winnerDF")
       #  print(winnerDF)
         winnerDF <- rbind(winnerDF, aStateOutcomeData[1,c(1,2)])
       # from old function return(stateOutcomeData[1,2])
     

      }

      #set winner DF rownames equal to States:
      rownames(winnerDF) <- NULL
      rownames(winnerDF) <- states




     # print("headwinnerDF")
      #print(head(winnerDF, 2))
      return(winnerDF)


  }

#similar loop as for worst but with edited ordering and "rank" instead of 1

  else if (rank == "best") {
    rank <- 1


    for (astate in states) {

### getting error when I try to subset/order/whatever i'm trying to do
         aStateOutcomeData <- stateOutcomeData[ which(stateOutcomeData$state == astate), c("state", "hospital", "outcome")]
        # order by outcome ascending then by Hospital Name (2)
            # might have to rename "outcome" to colName
         aStateOutcomeData <- aStateOutcomeData[order(aStateOutcomeData[,"outcome"], aStateOutcomeData[,2]), ]
         #add winner to winner df
         winnerDF <- rbind(winnerDF, aStateOutcomeData[rank,c(1,2)])
       # from old function return(stateOutcomeData[1,2])
     

      }

            #set winner DF rownames equal to States:
      rownames(winnerDF) <- NULL
      rownames(winnerDF) <- states

     # print("headwinnerDF")
      #print(head(winnerDF, 2))
      return(winnerDF)


  }


  
#same as abofe
  else {

 for (astate in states) {

### getting error when I try to subset/order/whatever i'm trying to do
         aStateOutcomeData <- stateOutcomeData[ which(stateOutcomeData$state == astate), c("state", "hospital", "outcome")]
        # order by outcome ascending then by Hospital Name (2)
            # might have to rename "outcome" to colName
         aStateOutcomeData <- aStateOutcomeData[order(aStateOutcomeData[,"outcome"], aStateOutcomeData[,2]), ]
         #add winner to winner df
         winnerDF <- rbind(winnerDF, aStateOutcomeData[rank,c(1,2)])
       # from old function return(stateOutcomeData[1,2])
     

      }

            #set winner DF rownames equal to States:
      rownames(winnerDF) <- NULL
      rownames(winnerDF) <- states

     # print("headwinnerDF")
      #print(head(winnerDF, 2))
      return(winnerDF)
  }
}      
}