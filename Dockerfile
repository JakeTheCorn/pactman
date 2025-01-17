FROM python:3.11.3-slim-buster as dev-base

ENV HISTFILE=/root/.history/.bash_history

ARG MY_VAR

RUN mkdir -p /root/.history
RUN touch /root/.history/.bash_history

RUN python -m pip install pip-tools

WORKDIR /code

COPY lib/requirements-manifests /code/requirements-manifests

RUN pip-compile -o /code/requirements-manifests/requirements.dev.txt /code/requirements-manifests/requirements.dev.in

RUN ls requirements-manifests

RUN pip install --requirement=requirements-manifests/requirements.dev.txt
