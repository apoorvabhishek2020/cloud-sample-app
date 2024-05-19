FROM python:3.12.3-alpine3.19
LABEL maintainer="apoorvabhishek.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
COPY ./cookbook /cookbook
COPY ./manage.py /manage.py
COPY ./db.sqlite3 /db.sqlite3
WORKDIR /
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]