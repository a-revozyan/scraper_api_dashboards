FROM python:3.10

RUN mkdir /srv/app
COPY ./app/ /srv/app/
WORKDIR /srv/app
RUN apt -y update && \
    pip install --upgrade pip && \
    pip install awscliv2 && \
    pip install -r /srv/app/requirements.txt && \
    mkdir -p /root/.aws

COPY aws/credentials /root/.aws

CMD ["python", "-u", "app.py"]