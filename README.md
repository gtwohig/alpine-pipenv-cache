# alpine-pipenv-cache
A simple python alpine base image with pipenv installed and a pipenv cache prepopulated with wheels that are unavailable 
on pypi and are very costly to build.

## Motivation
### The good (of python:alpine images)
Alpine is a great small base image with a minimal amount of cruft.

### The bad
Many popular packages do not publish Alpine wheels.

### The ugly
Building your own wheels kills you on several fronts:
1. Build dependencies bloat the lean image you started with. Sure you can clean them up, but it is a pain and the 
intermediate layers will still be huge.
2. Building packages like pandas and scipy take over 20 minutes.

## Usage

```dockerfile
FROM gtwohig/alpine-pipenv-cache:py3.7.0-alpine3.8

COPY my_code /my_code
WORKDIR my_code
RUN pipenv install && rm -rf /pipenv-cache && pipenv shell

```