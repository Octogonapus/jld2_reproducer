FROM ubuntu:22.04

# Setup container and install Julia

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -nv https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.2-linux-x86_64.tar.gz && \
    tar xf julia-1.9.2-linux-x86_64.tar.gz && \
    rm julia-1.9.2-linux-x86_64.tar.gz && \
    ln -s /julia-1.9.2/bin/julia /usr/local/bin/julia

RUN julia -e 'import Pkg; Pkg.add("JLD2")'
COPY step1.sh step1.sh
COPY step2.sh step2.sh

# First step - save an object with the first version of the structs
RUN sh step1.sh
# Second step - add a field to that struct and then load the object from disk
RUN sh step2.sh
