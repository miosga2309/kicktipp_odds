# kicktipp_odds
With a group of friends, we have a [kicktipp](https://www.kicktipp.de/) round where each participant needs to guess the results of the German Bundesliga games. The third rank gets the entrance fee back, the first two ranks win money and the others are financing those wins with the entrance fees. The one who performed the worst has to host the season ending which I got close to in the season 2019/20. 
To ensure that things do not get worse, I will work odds extracted via [The Odds API](https://the-odds-api.com/) and construct guesses based on our house rules. Also, I need to study the result distribution to not only guess the tendency correctly but to also make an informed decision about the goals per team.


**Rules per game day** (nine in total):
- The same tendency (win/draw/loss) for the home or away team can be guessed at maximum six times
- The same result (e.g., 2 : 1) can be guessed at maximum six times

**Scoring system**:
- Correct tendency + correct goals per team: 3 points
- Correct tendency: 1 point
- Else, 0 points
