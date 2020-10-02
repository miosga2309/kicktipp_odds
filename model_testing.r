library(dplyr)
library(nnet)
library(neuralnet)
library(ggplot2)
library(caret)

df <- read.csv("~/Desktop/kicktipp_odds/df.csv")

# averaging odds: odds are highly correlated and could cause problems for lm
hodds <- c("B365H","BWH","IWH","PSH","WHH","VCH","PSCH")
dodds <- c("B365D","BWD","IWD","PSD","WHD","VCD","PSCD")
aodds <- c("B365A","BWA","IWA","PSA","WHA","VCA","PSCA")

df <- mutate(df, hodds_mean = rowMeans(select(df, hodds), na.rm = TRUE))
df <- mutate(df, dodds_mean = rowMeans(select(df, dodds), na.rm = TRUE))
df <- mutate(df, aodds_mean = rowMeans(select(df, aodds), na.rm = TRUE))

# simple linear model testing
lin_mod_home <- lm(FTHG ~ hodds_mean + dodds_mean + aodds_mean + AwayTeam
                   + HomeTeam, data = df)
lin_mod_away <- lm(FTAG ~ hodds_mean + dodds_mean + aodds_mean + HomeTeam
                   + AwayTeam, data = df)

# ome hot encoding for home and away team
hot_home <- dummyVars(" ~ .", data = df["HomeTeam"])
hot_away <- dummyVars(" ~ .", data = df["AwayTeam"])
df_hot_home <- data.frame(predict(hot_home, newdata = df))
df_hot_away <- data.frame(predict(hot_away, newdata = df))
df <- cbind(df,df_hot_home,df_hot_away)

# neuralnet: predict FTHG and FTAG (other idea would be full time result FTR)
n <- names(df)
f <- as.formula(paste("FTHG + FTAG ~", paste(n[!n %in% c("FTHG","FTAG",
                                                         "FTR","Date","Div","HTHG",
                                                         "HTAG","HTR","HS","AS","HST",
                                                         "HF","AF","HC","AC","HY","AST",
                                                         "AY","HR","AR","B365H","B365A",
                                                         "BWH","BWD","IWH","IWD","IWA",
                                                         "PSH","PSD","PSA","WHH","WHD",
                                                         "WHA","VCH","VCD","VCA","PSCH",
                                                         "PSCD","PSCA","BWA","B365D")],
                                             collapse = " + ")))

nn <- neuralnet(f, data = df, hidden = c(7, 5, 2),
                act.fct = "tanh",
                linear.output = FALSE,
                lifesign = "minimal")

