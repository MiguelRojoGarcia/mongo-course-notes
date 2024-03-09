FROM ubuntu:jammy

LABEL authors="Miguel Rojo"

WORKDIR /app

ENV PYTHONPATH "${PYTHONPATH}:/app"

#OS update + install common packages
RUN apt-get update
RUN apt-get -y install software-properties-common gcc curl apt-transport-https vim bash-completion locales pkg-config libcairo2-dev

#Install python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get -y install python3.10
RUN apt-get -y install python3-pip

#Python installation
COPY requirements.txt /app/requirements.txt

RUN pip3 install --default-timeout=100 --no-cache-dir --upgrade -r  /app/requirements.txt

COPY . /app