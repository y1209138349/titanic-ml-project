FROM r-base:4.3.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('readr', 'dplyr'), repos='https://cran.rstudio.com/')"

COPY src/ ./src/
RUN mkdir -p /app/outputs

CMD ["Rscript", "src/r/analysis.R"]
