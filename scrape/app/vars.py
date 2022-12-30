# Variables for olx.uz
DOLLAR = 11550  # Rate Uzb/USD

BRAND = ['byd', 'kia', 'toyota', 'chevrolet', 'hyundai']   # Based on the list, selecting the brand of automobiles
AVTOELON = 'avtoelon.uz'                       # source, using in if statement
CSV_LIST = ['model', 'date', 'price', 'owner', 'year', 'color', 'transmission', 'odo', 'url'] # the list is used for creating csv files
CRAWLER_BUCKET = 'datacollectbucketcrawler1' # bucket for collecting data
DRIVER_PATH = '/usr/local/bin/chromedriver'

# Variables for avtoelon.uz
AVTOELON_NUMBER_OF_PAGES = '//*[@id="results"]/div[27]/div/div[2]/div/div/div[2]/ul/li[10]/span/a'
AVTOELON_DATE = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/div[3]/div/div[1]'
AVTOELON_PRICE = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/header/div[2]/span'
AVTOELON_MODEL = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/header/div[1]/div[1]/h1'
AVTOELON_YEAR = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/div[1]/div[1]/div/dl/dd[2]/a[2]'
AVTOELON_TRANSMISSION = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/div[1]/div[1]/div/dl/dd[6]/a[2]'
AVTOELON_COLOR = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/div[1]/div[1]/div/dl/dd[7]/a[2]'
AVTOELON_ODO = '/html/body/div[1]/div[1]/main/div/div[2]/section/div/div[1]/div[1]/div/dl/dd[5]'
