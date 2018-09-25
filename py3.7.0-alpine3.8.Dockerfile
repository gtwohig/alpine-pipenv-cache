FROM python:3.7.0-alpine3.8 AS builder

ENV PIPENV_CACHE_DIR=/pipenv-cache
RUN apk update
RUN apk add \
    ca-certificates \
    libstdc++ \
    libgfortran \
    bash \
    gfortran \
    g++ \
    make \
    python3-dev \
    build-base \
    wget \
    freetype-dev \
    libpng-dev \
    openblas-dev
RUN pip install pipenv
COPY Pipfile /Pipfile
COPY Pipfile.lock /Pipfile.lock
RUN pipenv install

FROM python:3.7.0-alpine3.8
ENV PIPENV_CACHE_DIR=/pipenv-cache
RUN pip install pipenv
COPY --from=builder /pipenv-cache /pipenv-cache/
