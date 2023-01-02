import pandas as pd
import boto3, glob, os
from dicts import *

s3_client = boto3.client('s3')
S3_BUCKET = 'datacollectbucketcrawler1'
SOURCE = 'avtoelon.uz'


def generating_csvs_test():
    # Downloads CSV files from S3 bucket
    s3_client.download_file(S3_BUCKET, f'files/cars_{SOURCE}.csv',
                            f'files/cars_{SOURCE}.csv')
    csv_file = f'files/cars_{SOURCE}.csv'
    data = pd.read_csv(csv_file)
    # all_files_bmw = glob.glob(os.path.join('files/' '*.csv'))
    # print(all_files_bmw)
    # li = []
    # for filename in all_files_bmw:
    #     df = pd.read_csv(filename, index_col=None, header=0)
    #     li.append(df)
    # data = pd.concat(li, axis=0, ignore_index=True)



    # for key, value in models_dict.items():
    #     data.loc[data['model'] == key, 'model'] = value
        # indexstatus = data[(data['color'])].index
        # indexstatus = data[
        #     (data['color'] != 'excellent') & (data['status'] != 'good') & (data['status'] != 'normal')].index
        # data.drop(indexstatus, inplace=True)

    price_data = data.groupby(['model', 'year', 'color'])['price'].mean().to_frame()
    price_data.to_csv(f'files/finished.csv')
    for file in os.listdir('files/'):
        if 'finished.csv' != file and 'test.txt' != file:
            os.remove(f'files/{file}')