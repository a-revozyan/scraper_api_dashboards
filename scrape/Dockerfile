FROM python:3.10

RUN mkdir /srv/app
COPY ./app/ /srv/app/
WORKDIR /srv/app
RUN apt -y update && \
    pip install --upgrade pip && \
    apt install unzip -y && \
    pip install awscliv2 && \
    pip install -r /srv/app/requirements.txt && \
    mkdir -p /root/.aws

COPY aws/credentials /root/.aws

# Install chromedriver
RUN wget -N https://chromedriver.storage.googleapis.com/107.0.5304.62/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    mv -f ~/chromedriver /usr/local/bin/chromedriver && \
    chown root:root /usr/local/bin/chromedriver && \
    chmod 0755 /usr/local/bin/chromedriver &&\
    # Install chrome broswer
    curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -y update && \
    apt-get -y install google-chrome-stable


CMD ["python", "-u", "app.py"]


