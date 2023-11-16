FROM python:3.11-alpine

RUN addgroup -S worker && adduser -S worker -G worker
USER worker
WORKDIR /code
COPY --chown=worker:worker python-code /code
RUN pip install -r requirements.txt --no-cache-dir

CMD python app.py
EXPOSE 5000