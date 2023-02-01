import pandas as pd
import boto3, os

s3_client = boto3.client('s3')
# S3_BUCKET = 'carsdatascraperapidash1'
S3_BUCKET = 'datacollectbucketcrawler1'
SOURCE = 'avtoelon.uz'


def generating_csvs_test():
    # Downloads CSV files from S3 bucket
    s3_client.download_file(S3_BUCKET, f'files/cars_{SOURCE}.csv',
                            f'files/cars_{SOURCE}.csv')
    csv_file = f'files/cars_{SOURCE}.csv'
    data = pd.read_csv(csv_file)

    price_data = data.groupby(['model', 'year', 'color'])['price'].mean().to_frame()
    price_data.to_csv(f'files/finished.csv')
    for file in os.listdir('files/'):
        if 'finished.csv' != file and 'test.txt' != file:
            os.remove(f'files/{file}')