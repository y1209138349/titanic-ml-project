FROM r-base:4.3.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY packages.R .
RUN Rscript packages.R

COPY . .
RUN mkdir -p /app/outputs

CMD ["Rscript", "analysis.R"]
