FROM python:3.9	
LABEL maintainer="esthermban.com"
# Déclarer les arguments en haut	
ENV PYTHONUNBUFFERED 1
ARG DEV=false	
# Définir le répertoire de travail	
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
	

WORKDIR /app


EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"
 
USER django-user