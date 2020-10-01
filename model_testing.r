library(dplyr)

df <- read.csv("~/Desktop/kicktipp_odds/df.csv")

# averaging odds: odds are highly correlated and could cause problems for lm
hodds <- c("B365H","BWH","IWH","PSH","WHH","VCH","PSCH")
dodds <- c("B365D","BWD","IWD","PSD","WHD","VCD","PSCD")
aodds <- c("B365A","BWA","IWA","PSA","WHA","VCA","PSCA")

df <- mutate(df, hodds_mean = rowMeans(select(df, hodds), na.rm = TRUE))
df <- mutate(df, dodds_mean = rowMeans(select(df, dodds), na.rm = TRUE))
df <- mutate(df, aodds_mean = rowMeans(select(df, aodds), na.rm = TRUE))

# simple linear model testing
lin_mod_home <- lm(FTHG ~ hodds_mean + dodds_mean + aodds_mean + AwayTeam, data = df)
lin_mod_away <- lm(FTAG ~ hodds_mean + dodds_mean + aodds_mean + HomeTeam, data = df)
