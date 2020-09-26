import json
import requests

# An api key is emailed to you when you sign up to a plan
key_obj = open('/Users/jonasmiosga/Desktop/kicktipp_odds/key.txt', 'r')
key_line = key_obj.readlines()
api_key = str(key_line[0])
api_key = api_key.rstrip()

# First get a list of in-season sports
sports_response = requests.get('https://api.the-odds-api.com/v3/sports', params={
    'api_key': api_key
})

sports_json = json.loads(sports_response.text)

if not sports_json['success']:
    print(
        'There was a problem with the sports request:',
        sports_json['msg']
    )

else:
    print()
    print(
        'Successfully got {} sports'.format(len(sports_json['data'])),
        'Here\'s the first sport:'
    )
    print(sports_json['data'][0])



# To get odds for a sepcific sport, use the sport key from the last request
#   or set sport to "upcoming" to see live and upcoming across all sports
sport_key = 'soccer_germany_bundesliga'

odds_response = requests.get('https://api.the-odds-api.com/v3/odds', params={
    'api_key': api_key,
    'sport': sport_key,
    'region': 'eu', # uk | us | eu | au
    'mkt': 'h2h' # h2h | spreads | totals
})

odds_json = json.loads(odds_response.text)
if not odds_json['success']:
    print(
        'There was a problem with the odds request:',
        odds_json['msg']
    )

else:
    # odds_json['data'] contains a list of live and
    #   upcoming events and odds for different bookmakers.
    # Events are ordered by start time (live events are first)
    print()
    print(
        'Successfully got {} events'.format(len(odds_json['data'])),
        'Here\'s the first event:'
    )
    print(odds_json['data'][0])

    # Check your usage
    print()
    print('Remaining requests', odds_response.headers['x-requests-remaining'])
    print('Used requests', odds_response.headers['x-requests-used'])
