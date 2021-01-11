df <- read.csv("https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv")
df <- df[df$league_id == 1845,]

perf <- function(seas) {
  # filter season
  t <- df[df$season == seas,]
  # initiate kicktipp score column
  t$kt_score <- NA
  # calculate points
  t$kt_score[round(t$proj_score1) > round(t$proj_score2) # tendency
             & t$score1 > t$score2] <- 1
  t$kt_score[round(t$proj_score1) < round(t$proj_score2) # tendency
             & t$score1 < t$score2] <- 1
  t$kt_score[round(t$proj_score1) == round(t$proj_score2) # tendency
             & t$score1 == t$score2] <- 1
  t$kt_score[round(t$proj_score1) == t$score1 # exact
             & round(t$proj_score2) == t$score2] <- 3
  t$kt_score[is.na(t$kt_score)] <- 0
  return(t)
}

for (i in 2016:2020) {
  print(sum(perf(i)$kt_score))
}
