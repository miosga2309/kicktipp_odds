def update_df():
    import pandas

    # load latest dataset
    df = pandas.read_csv("/Users/jonasmiosga/Desktop/kicktipp_odds/v1_result_based/data/df.csv", encoding = 'utf-8')

    # download newest version of this season's dataset
    new = pandas.read_csv("http://www.football-data.co.uk/mmz4281/2021/D1.csv", encoding = 'utf-8')

    # find equal variables
    col_list = list(set(list(df)).intersection(list(new)))

    # filter dataframes by common variables
    df = df.filter(items=col_list)
    new = new.filter(items=col_list)

    # save new updated dataset
    df = pandas.concat([df,new]).drop_duplicates(subset='Date').reset_index(drop=True)
    df.to_csv('/Users/jonasmiosga/Desktop/kicktipp_odds/v1_result_based/data/df.csv', index=False, encoding = 'utf-8')

if __name__ == '__main__':
    update_df()
