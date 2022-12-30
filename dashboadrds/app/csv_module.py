import pandas as pd
import boto3, glob, os
from dicts import *


s3_client = boto3.client('s3')
S3_BUCKET = 'datacollectbucketcrawler1'
BRANDS = ['byd']#, 'hyundai']   # Based on the list, selecting the brand of automobiles
SOURCES = ['avtoelon.uz']


def generating_csvs_test():
    # Downloads CSV files from S3 bucket
    for brand in BRANDS:
        s3_client.download_file(S3_BUCKET, f'files/{brand}_{SOURCES[0]}.csv',
                                f'files/{brand}_{SOURCES[0]}.csv')
        # s3_client.download_file(S3_BUCKET, f'files/{brand}_{SOURCES[1]}.csv',
        #                         f'files/{brand}_{SOURCES[1]}.csv')
    # works with BMW
    all_files_bmw = glob.glob(os.path.join('files/' '*.csv'))
    print(all_files_bmw)
    li = []
    for filename in all_files_bmw:
        df = pd.read_csv(filename, index_col=None, header=0)
        li.append(df)
    data = pd.concat(li, axis=0, ignore_index=True)

    for key, value in models_dict.items():
        data.loc[data['model'] == key, 'model'] = value
        indexstatus = data[(data['status'] != 'excellent') & (data['status'] != 'good') & (data['status'] != 'normal')].index
        data.drop(indexstatus, inplace=True)

    price_data = data.groupby(['model', 'year', 'status'])['price'].mean().to_frame()
    price_data.to_csv(f'files/finished.csv')
    for file in os.listdir('files/'):
        if 'finished.csv' != file and 'test.txt' != file:
            os.remove(f'files/{file}')