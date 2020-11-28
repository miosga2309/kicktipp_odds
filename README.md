# kicktipp_odds
With a group of friends, we have a [kicktipp](https://www.kicktipp.de/) round where each participant needs to guess the results of the German Bundesliga games. The third rank gets the entrance fee back, the first two ranks win money and the others are financing those wins with the entrance fees. The one who performed the worst has to host the season ending which I got close to in the season 2019/20.

To ensure that things do not get worse, I will work odds extracted via [The Odds API](https://the-odds-api.com/) and construct guesses based on our house rules. The correct result is to be guessed by a machine learning algorithm that is based on the games from the seasons from 2015/16 until today. The data is retrieved from [football-data.co.uk](http://www.football-data.co.uk/germanym.php) and recombined in one dataset by me. The variables are described in the [notes](http://www.football-data.co.uk/notes.txt) which was downloaded at the homepage the data is from.

The API key is stored in a hidden (ignored) text file. To use the code, one can retrieve a key by creating an account (Starter for free) at [The Odds API](https://the-odds-api.com/).

**Rules per game day** (nine in total):
- The same tendency (win/draw/loss) for the home or away team can be guessed at maximum six times
- The same result (e.g., 2 : 1) can be guessed at maximum six times

**Scoring system**:
- Correct tendency + correct goals per team: 3 points
- Correct tendency: 1 point
- Else, 0 points

## Workflow for a new gameday
- update the dataset of past games with the data from football-data (results and odds)
- add revolution to neural net
- fetch new gameday data from The Odds API (games and odds)
- enter results in Kicktipp
