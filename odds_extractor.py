import json
import requests
import numpy as np
import pandas as pd
from datetime import datetime

# API key
key_obj = open('/Users/jonasmiosga/Desktop/kicktipp_odds/key.txt', 'r')
key_line = key_obj.readlines()
api_key = str(key_line[0])
api_key = api_key.rstrip()


# only retrieve Bundesliga data
sport_key = 'soccer_germany_bundesliga'

odds_response = requests.get('https://api.the-odds-api.com/v3/odds', params={
    'api_key': api_key,
    'sport': sport_key,
    'region': 'eu',
    'mkt': 'h2h' # h2h (head to head)
})

odds_json = json.loads(odds_response.text)
if not odds_json['success']:
    print(
        'There was a problem with the odds request:',
        odds_json['msg']
    )

else:
    # odds_json['data'] contains a list of live and upcoming events and odds
    all_lists = []

    for i in range(0,len(odds_json['data'])):
        ind_list = []
        ts = odds_json['data'][i]['commence_time']
        ind_list.append(datetime.utcfromtimestamp(ts).strftime('%Y-%m-%d'))
        home_t = odds_json['data'][i]['home_team']
        ind_list.append(home_t)
        ind_list.append("".join(set(odds_json['data'][i]['teams'])-set([home_t])))

        multiple_lists = []
        for j in range(0,len(odds_json['data'][i]['sites'])):
            multiple_lists.append(odds_json['data'][i]['sites'][j]['odds']['h2h'])
        arrays = [np.array(x) for x in multiple_lists]
        mean_odds = [np.mean(k) for k in zip(*arrays)]
        [ind_list.append(round(x,2)) for x in mean_odds]
        ind_list.append(odds_json['data'][i]['sites_count'])
        all_lists.append(ind_list)

    df = pd.DataFrame(all_lists, columns = ['date', 'home_team', 'opponent',
                                            '1', 'X', '2','n_providers'])
    print(df)

    # check usage
    print()
    print('Remaining requests', odds_response.headers['x-requests-remaining'])
    print('Used requests', odds_response.headers['x-requests-used'])




#### appendix ####
# get a list of in-season sports
switch = 0
if switch == 1:
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

    ## event import message
    print()
    print(
        'Successfully got {} events'.format(len(odds_json['data'])),
        'Here\'s the first event:'
    )
    print(odds_json['data'][0])
