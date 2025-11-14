FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app
RUN rm -rf /app/Dockerfile /app/db.sqlite3 /app/.venv /app/.idea /app/.git

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc pkg-config default-libmysqlclient-dev netcat-traditional \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir django mysqlclient

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
