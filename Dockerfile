FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY src/ ./src/
RUN mkdir -p /app/outputs

CMD ["python", "src/python/analysis.py"]
