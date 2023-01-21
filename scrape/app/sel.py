from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
from datetime import datetime
from dicts import car_months, car_colors, car_transmission
from vars import *


class Sel:

    __slots__ = ['__options', '__chrome_driver_path', '__driver', 'model', 'date', 'price', 'owner', 'year', 'color',
                 'transmission', 'odo', 'counts']

    AVTOELON_MAIN_LIST = []  # this list is used for collecting urls of ads of https://avtoelon.uz
    AVTOELON_LIST = []  # this list is used for collecting temp dict which is build based on elements of the AVTOELON_MAIN_LIST

    def __init__(self, path):
        """Initialization selenium instance"""
        self.__options = webdriver.ChromeOptions()
        self.__options.add_experimental_option("detach", False)
        self.__options.add_argument("--headless")
        self.__options.add_argument("--disable-gpu")
        self.__options.add_argument("--no-sandbox")
        self.__options.add_argument('--disable-dev-shm-usage')
        self.__chrome_driver_path = Service(path)
        self.__driver = webdriver.Chrome(options=self.__options, service=self.__chrome_driver_path)
        self.model = ''
        self.date = ''
        self.price = ''
        self.owner = ''
        self.year = ''
        self.color = ''
        self.transmission = ''
        self.odo = ''

    def __repr__(self):
        return f'The class of Selenium - scrape'

    def __str__(self):
        return f'The class of Selenium - scrape'

    def get_counts(self, url, xpath):
        """Collecting the biggest number of pages of the default page 'olx.uz', using as last number of 'counts' var"""
        self.__driver.get(url)
        self.__driver.implicitly_wait(15)                                  # waiting till url is loading                                         # if avtoelon.uz in url
        # self.counts = int(1)
        try:
            self.counts = self.__driver.find_element(By.XPATH, xpath) # getting the last number of pages
            self.counts = int(self.counts.text)                     # this variable is used in for loop in app.py
        except NoSuchElementException:
            self.counts = int(5)                                    # if less than 10 pages, selecting just 5 pages
        return self.counts

    def get_urls(self, url):
        """Collecting all 'hrefs' from each page, adding these hrefs to the 'MAIN_LIST', which will be used for the next parsing"""
        self.__driver.get(url)
        self.__driver.implicitly_wait(5)                                                  # waiting till url is loading                                     # if olx.uz in url
        elements = self.__driver.find_elements(By.CSS_SELECTOR, 'span.a-el-info-title a') # getting hrefs by CSS class
        for x in elements:
            Sel.AVTOELON_MAIN_LIST.append(x.get_attribute('href'))                          # added to the AVTOELON_MAIN_LIST links

    def get_values(self, url):
        try:
            self.__driver.get(url)
            self.__driver.implicitly_wait(5)                                                 # waiting till url is loading
            self.date = self.__driver.find_element(By.XPATH, AVTOELON_DATE).text[12:].replace(" ", "")
            for key, value in car_months.items():
                if key in self.date:
                    now = datetime.now().strftime('%Y')
                    self.date = self.date.replace(key, value) + now
            self.price = self.__driver.find_element(By.XPATH, AVTOELON_PRICE).text[:-5].replace(" ", "").replace("~", "")
            self.owner = 'not_in_avtoelon'
            self.model = self.__driver.find_element(By.XPATH, AVTOELON_MODEL).text.lower()
            if 'позиция' in self.model:
                self.model = self.model.replace('позиция', 'position')
            elif 'евро' in self.model:
                self.model = self.model.replace('евро', 'euro')
            elif 'газ-бензин' in self.model:
                self.model = self.model.replace('газ-бензин', 'gas-gasoline')
            count = 1
            list_of_text = []
            while True:
                try:
                    self.__driver.find_element(By.XPATH, f'{AVTOELON_NUMBER_VALUES}[{count}]')
                    count += 1
                except NoSuchElementException:
                    count = count - 1
                    break

            for x in range(2, count):
                try:
                    value = self.__driver.find_element(By.XPATH,
                                                     f'{AVTOELON_LIST_OF_TEXTS}[{x}]').text
                    list_of_text.append(value)
                except NoSuchElementException:
                    break
            self.odo = '0'
            for x in list_of_text:
                if x in car_colors:
                    self.color = car_colors[x]
                elif x in car_transmission:
                    self.transmission = car_transmission[x]
                elif ' км' in x:
                    odo = x.replace(' км', '').replace(' ', '')
                    self.odo = odo
            self.year = list_of_text[0]

            temp = {
                "model": f"{self.model}",
                "date": f"{self.date}",
                "price": f"{self.price}",
                "owner": f"{self.owner}",
                "year": f"{self.year}",
                "color": f"{self.color}",
                "transmission": f"{self.transmission}",
                "odo": f"{self.odo}",
                "url": f"{url}"
            }
            Sel.AVTOELON_LIST.append(temp)
        except:
            pass