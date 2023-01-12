from sel import Sel, AVTOELON_LIST, AVTOELON_MAIN_LIST
import boto3, csv
from vars import *
from os import remove
from datetime import date
from time import sleep


bot = Sel(path=DRIVER_PATH)
while True:
    if date.today().weekday() == 3:
        def file_creating(list, source):
            """Creating a new csv file from the list, in files directory"""
            new_file = f'files/cars_{source}.csv'
            with open(new_file, 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(CSV_LIST)
                for row in list:
                    try:
                        if any(row):
                            writer.writerow(row.values())
                    except:
                        pass
            s3_client = boto3.client('s3')
            s3_client.upload_file(
                f'{new_file}', CRAWLER_BUCKET, f'{new_file}'
            )
            remove(new_file)
            AVTOELON_LIST = []
            AVTOELON_MAIN_LIST = []

        for br in BRAND:
            bot.get_counts(url=f'https://avtoelon.uz/avto/{br}/gorod-tashkent/', xpath=AVTOELON_NUMBER_OF_PAGES)
            counts = bot.counts
            print(f'Scraper has just found {counts} of pages with ads of {br} - AVTOELON.UZ')
            for x in range(0, counts):
                bot.get_urls(url=f"https://avtoelon.uz/avto/{br}/gorod-tashkent/?page={str(x)}")
            print(f'There is a number of total ads from the founded pages {len(AVTOELON_MAIN_LIST)} - AVTOELON.UZ')

        for x in AVTOELON_MAIN_LIST:
            bot.get_values(x)
        print(f'Scraper finished of getting values from the all urls of car ads - AVTOELON.UZ')
        file_creating(list=AVTOELON_LIST, source=AVTOELON)
        print(f'The new file has just been created and uploaded to S3 - AVTOELON.UZ')
        sleep(86400)
    else:
        print('today is not Friday')
        sleep(86400)

