#' Additional Data for Trackman
#'
#' Adds data fields describing the game such as pitcher's pitch count, at bat of game, etc
#'
#' @param d a dataframe containing trackman data
#' @return a dataframe containing trackman data with extra columns

tmplus <- function(d) {
  d %>%
    batterpa2() %>%
    gamepa() %>%
    pitchcount()
}

#Adds hitter's plate appearance of the game count
batterpa2 <- function(d) {
  d %>% arrange(PitchNo) -> sortd
  batpa <- numeric()
  for (batter in unique(sortd[['Batter']])) {
    pa <- 0
    inn <- 0
    panum <- 0
    for (i in 1:nrow(sortd)) {
      pitch <- sortd[i,]
      if (pitch[['Batter']] == batter) {
        if (pitch[['PAofInning']] != pa || pitch[['Inning']] != inn) {
          panum <- panum + 1
          pa <- pitch[['PAofInning']]
          inn <-  pitch[['Inning']]
        }
        batpa[i] <- panum
      }
    }
  }
  d %>%
    mutate(BatterPA = batpa)
}

#Adds total plate appearance of the game number
gamepa <- function(d) {
  d %>% arrange(PitchNo) -> sortd
  painn <- 0
  pa <- numeric()
  pacount <- 0
  for (i in 1:nrow(sortd)) {
    pitch <- sortd[i,]
    if (pitch$PAofInning != painn) {
      pacount <- pacount + 1
      painn <- pitch$PAofInning
    }
    pa[i] <- pacount
  }
  sortd %>%
    mutate(PAofGame = pa)
}

#adds pitcher-specific pitchcounts to trackman data
pitchcount <- function(d) {
  d %>% arrange(PitchNo) -> sortd
  pitchcount <- NULL
  for (pitcher in unique(d$Pitcher)) {
    pc <- 0
    for (i in 1:nrow(d)) {
      if (d[i, "Pitcher"] == pitcher) {
        pc <- pc + 1
        pitchcount[i] <- pc
      }
    }
  }
  d %>%
    mutate(PitchCount = pitchcount)
}

