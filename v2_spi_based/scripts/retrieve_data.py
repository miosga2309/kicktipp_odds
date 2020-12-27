def retrieve():
    import pandas as pd

    # load latest datasets
    all = pd.read_csv("https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv")
    spi = pd.read_csv("https://projects.fivethirtyeight.com/soccer-api/club/spi_global_rankings.csv")




if __name__ == '__main__':
    retrieve()
