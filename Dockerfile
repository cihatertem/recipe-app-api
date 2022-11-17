FROM python:3.10.8-alpine3.16
LABEL maintainer="cihatertem.dev"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements_dev.txt /tmp/requirements_dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /venv/bin/pip install -r /tmp/requirements_dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/venv/bin:$PATH"

USER django-user