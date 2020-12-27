df <- read.csv("~/Desktop/kicktipp_odds/2020_21_4.csv")
r <- matrix(NA,9,dim(frame)[2])
df[1:9, ] <- r
# 1
df$HomeTeam.Mainz[1] <- 1
df$AwayTeam.Leverkusen[1] <- 1
df$hodds_mean[1] <- 1.61
df$dodds_mean[1] <- 5.16
df$aodds_mean[1] <- 4.39
# 2
df$HomeTeam.Hertha[2] <- 1
df$AwayTeam.Stuttgart[2] <- 1
df$hodds_mean[2] <- 2.08
df$dodds_mean[2] <- 3.38
df$aodds_mean[2] <- 3.79
# 3
df$HomeTeam.Augsburg[3] <- 1
df$AwayTeam.RB.Leipzig [3] <- 1
df$hodds_mean[3] <- 5.66
df$dodds_mean[3] <- 1.56
df$aodds_mean[3] <- 4.43
# 4
df$HomeTeam.Freiburg[4] <- 1
df$AwayTeam.Werder.Bremen [4] <- 1
df$hodds_mean[4] <- 2.27
df$dodds_mean[4] <- 3.17
df$aodds_mean[4] <- 3.50
# 5
df$HomeTeam.Hoffenheim[5] <- 1
df$AwayTeam.Dortmund[5] <- 1
df$hodds_mean[5] <- 1.75
df$dodds_mean[5] <- 4.25
df$aodds_mean[5] <- 4.27
# 6
