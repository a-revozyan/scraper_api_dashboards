import csv, boto3, os
import flask


s3_client = boto3.client('s3')
S3_BUCKET = 'datacollectbucketcrawler1'
AVTOELON = 'avtoelon.uz'

def csv_downloads():
    """This method allows to download csv files based on company: ['bmw', 'chevrolet', 'hyundai']"""
    # removing all csvs before downloading the new one
    for i in os.listdir('static/'):
        if i.endswith(".csv"):
            os.remove(f'static/{i}')
    s3_client.download_file(S3_BUCKET, f'files/cars_{AVTOELON}.csv',
                            f'static/cars_{AVTOELON}.csv')
    csv_object = f'static/cars_{AVTOELON}.csv'

    return flask.send_file(csv_object, mimetype='text/csv', as_attachment=True)


class MyApi:
    def main_csv_to_json(**args):
        """This method allows us to get list of dictionaries"""
        global MAIN_LIST
        s3_client.download_file(S3_BUCKET, f'files/cars_{AVTOELON}.csv',
                                f'static/cars_{AVTOELON}.csv')


        MAIN_LIST = []
        with open(f'static/cars_{AVTOELON}.csv', encoding='utf-8') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            column_list = [column for column in csv_reader.fieldnames]
            dict_list = [row for row in csv_reader]
            if len(args.items()) == 1:
                for key, value in args.items():
                    if key == 'model' and key in column_list:
                        MAIN_LIST = [dict for dict in dict_list for key1, value2 in dict.items() if value == value2]
            if len(args.items()) == 2:
                for key, value in args.items():
                    if key == 'model' and key in column_list:
                        first_list = [dict for dict in dict_list for key1, value2 in dict.items() if value == value2]
                    elif key == 'color' and key in column_list:
                        MAIN_LIST = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]
                    elif key == 'transmission' and key in column_list:
                        MAIN_LIST = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]
                    elif key == 'year' and key in column_list:
                        MAIN_LIST = [dict for dict in first_list for key1, value2 in dict.items() if value == value2]

        for i in os.listdir('static/'):
            if i.endswith(".csv"):
                os.remove(f'static/{i}')

        return MAIN_LIST

