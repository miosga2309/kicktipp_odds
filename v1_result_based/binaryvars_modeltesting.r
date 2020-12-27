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

# ome hot encoding for home and away team, goals of home and away team
hot_home <- dummyVars(" ~ .", data = df["HomeTeam"])
df_hot_home <- data.frame(predict(hot_home, newdata = df))
hot_away <- dummyVars(" ~ .", data = df["AwayTeam"])
df_hot_away <- data.frame(predict(hot_away, newdata = df))

df["FTHG"] <- lapply(df["FTHG"], as.character)
hot_home_goals <- dummyVars(" ~ .", data = df["FTHG"])
df_hot_home_goals <- data.frame(predict(hot_home_goals, newdata = df))

df["FTAG"] <- lapply(df["FTAG"], as.character)
hot_away_goals <- dummyVars(" ~ .", data = df["FTAG"])
df_hot_away_goals <- data.frame(predict(hot_away_goals, newdata = df))

### outcome (goals) must be factorized and one-hot encoded so that probabilities
# are available per number of goals 

df <- cbind(df,df_hot_home,df_hot_away,df_hot_home_goals,df_hot_away_goals)
write.csv(df,"/Users/jonasmiosga/Desktop/kicktipp_odds/df_nn.csv")
# neuralnet: predict FTHG and FTAG (other idea would be full time result FTR)
n <- names(df)
n_hot <- names(df[47:96])
n_independent <- n[!n %in% c("FTHG","FTAG","AwayTeam","HomeTeam",
                             "FTR","Date","Div","HTHG",
                             "HTAG","HTR","HS","AS","HST",
                             "HF","AF","HC","AC","HY","AST",
                             "AY","HR","AR","B365H","B365A",
                             "BWH","BWD","IWH","IWD","IWA",
                             "PSH","PSD","PSA","WHH","WHD",
                             "WHA","VCH","VCD","VCA","PSCH",
                             "PSCD","PSCA","BWA","B365D",
                             "FTHG0","FTHG1","FTHG2","FTHG3",
                             "FTHG4","FTHG5","FTHG6","FTHG7",
                             "FTHG8","FTAG0","FTAG1","FTAG2",
                             "FTAG3","FTAG4","FTAG5","FTAG6")]
f <- as.formula(paste("FTHG0 + FTHG1 + FTHG2 + FTHG3 + FTHG4 + FTHG5 + FTHG6 + FTHG7 + FTHG8 +
                      FTAG0 + FTAG1 + FTAG2 + FTAG3 + FTAG4 + FTAG5 + FTAG6 ~",
                      paste(n[!n %in% c("FTHG","FTAG","AwayTeam","HomeTeam",
                                        "FTR","Date","Div","HTHG","HTAG","HTR",
                                        "HS","AS","HST","HF","AF","HC","AC","HY","AST",
                                        "AY","HR","AR","B365H","B365A","BWH","BWD",
                                        "IWH","IWD","IWA","PSH","PSD","PSA","WHH","WHD",
                                        "WHA","VCH","VCD","VCA","PSCH","PSCD","PSCA",
                                        "BWA","B365D","FTHG0","FTHG1","FTHG2","FTHG3",
                                        "FTHG4","FTHG5","FTHG6","FTHG7","FTHG8","FTAG0",
                                        "FTAG1","FTAG2","FTAG3","FTAG4","FTAG5","FTAG6")],
                                             collapse = " + ")))

nn <- neuralnet(f, data = df, hidden = c(7, 5, 2),
                act.fct = "tanh",
                linear.output = FALSE,
                lifesign = "minimal",
                stepmax = 100,
                rep = 100)

compute(nn, df[, n_independent])
