[![Build Status](https://travis-ci.com/ropod-project/docker.svg?branch=master)](https://travis-ci.com/ropod-project/docker)

# docker

This repository contains the public docker images for the ROPOD project.

## Build

### Base image

To build the base image:

```
docker build -t ropod/ropod-base .

```

## Usage

To run some of our code inside a docker container:

```
docker run -it --mount type=bind,source=<root_of_source_repositories>,target=/workspace ropod/ropod-base
```

To use this as a base image, e.g. in our continuous integration:

```docker

FROM ropod/ropod-base:latest
```
