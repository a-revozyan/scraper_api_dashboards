import csv, boto3, os
import flask


s3_client = boto3.client('s3')
S3_BUCKET = 'datacollectbucketcrawler1'
AVTOELON_S3_DIR = 'avtoelon.uz'
OLX_S3_DIR = 'olx.uz'
BRANDS = ['bmw']#, 'chevrolet', 'hyundai']   # Based on the list, selecting the brand of automobiles
SOURCES = ['olx.uz', 'avtoelon.uz']


class MyApi:
    def main_csv_to_json(company, **args):
        """This method allows us to get list of dictionaries"""
        global MAIN_LIST
        for brand in BRANDS:
            s3_client.download_file(S3_BUCKET, f'files/{brand}_{SOURCES[0]}.csv',
                                    f'static/{brand}_{SOURCES[0]}.csv')
            s3_client.download_file(S3_BUCKET, f'files/{brand}_{SOURCES[1]}.csv',
                                    f'static/{brand}_{SOURCES[1]}.csv')

        for brand in BRANDS:
            MAIN_LIST = []
            list_of_csvs = [i for i in os.listdir('static/') if brand in i]
            for one_csv in list_of_csvs:
                with open(f'static/{one_csv}', encoding='utf-8') as csv_file:
                    csv_reader = csv.DictReader(csv_file)
                    column_list = [column for column in csv_reader.fieldnames]
                    dict_list = [row for row in csv_reader]
                    print(f'length of dict list is {len(dict_list)}')
                    for key, value in args.items():
                        if key == 'model' and key in column_list:
                            first_list = [dict for dict in dict_list for key1, value2 in dict.items() if value == value2]
                            print(f'length of dict list is {len(first_list)} - model')
                    for key, value in args.items():
                        if key == 'color' and key in column_list:
                            first_list = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]
                            print(f'length of dict list is {len(first_list)} - color')
                            MAIN_LIST += first_list
                            print(f'length of MAIN LIST is {len(MAIN_LIST)} - color')
                        elif key == 'transmission' and key in column_list:
                            first_list = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]
                            print(f'length of dict list is {len(first_list)} - transmission')
                            MAIN_LIST += first_list
                            print(f'length of MAIN LIST is {len(MAIN_LIST)} - transmission')
                        elif key == 'year' and key in column_list:
                            first_list = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]
                            print(f'length of dict list is {len(first_list)} - year')
                            MAIN_LIST += first_list
                            print(f'length of MAIN LIST is {len(MAIN_LIST)} - year')

        for i in os.listdir('static/'):
            if i.endswith(".csv"):
                os.remove(f'static/{i}')

        return MAIN_LIST

    def csv_downloads(company, source):
        """This method allows to download csv files based on company: ['bmw', 'chevrolet', 'hyundai']"""
        # removing all csvs before downloading the new one
        for i in os.listdir('static/'):
            if i.endswith(".csv"):
                os.remove(f'static/{i}')
        if "olx" in source:
            s3_client.download_file(S3_BUCKET, f'files/{company}_{SOURCES[0]}.csv',
                                    f'static\{company}_{SOURCES[0]}.csv')
            csv_object = f'static/{company}_{SOURCES[0]}.csv'
            return flask.send_file(csv_object, mimetype='text/csv', as_attachment=True)

        elif 'avtoelon' in source:
            s3_client.download_file(S3_BUCKET, f'files/{company}_{SOURCES[1]}.csv',
                                    f'static/{company}_{SOURCES[1]}.csv')
            csv_object = f'static/{company}_{SOURCES[1]}.csv'

            return flask.send_file(csv_object, mimetype='text/csv', as_attachment=True)