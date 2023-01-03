FROM python:3.10

RUN mkdir /srv/app
WORKDIR /srv/app

COPY ./app/ /srv/app/
RUN apt-get -y update
RUN pip install --upgrade pip
RUN pip install -r /srv/app/requirements.txt


CMD ["python", "-u", "app.py"]
