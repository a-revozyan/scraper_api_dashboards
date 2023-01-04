FROM python:3.10

RUN mkdir /srv/app
COPY ./app/ /srv/app/
WORKDIR /srv/app
RUN apt -y update && \
    pip install --upgrade pip && \
    pip install -r /srv/app/requirements.txt

CMD ["python", "-u", "app.py"]