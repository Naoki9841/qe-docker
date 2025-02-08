# Dockerfile for quantum espresso ver7.3.1 and Python-3.9.4

# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set the frontend to noninteractive to prevent interactive prompts during installation
# switch off this line for debugging
ENV DEBIAN_FRONTEND "noninteractive"

# Install necessary packages
RUN apt-get update \
    && apt-get install -y \
        git \
        vim \
        curl \
        build-essential \
        gcc \
        gfortran \
        gnuplot \
        openmpi-doc \
        openmpi-bin \
        libopenmpi-dev \
        openssl \
        libssl-dev \
        libreadline-dev \
        ncurses-dev \
        bzip2 \
        zlib1g-dev \
        libbz2-dev \
        libffi-dev \
        libopenblas-dev \
        liblapack-dev \
        libsqlite3-dev \
        liblzma-dev \
        libpng-dev \
        libfreetype6-dev

# OpenMPI configuration
ENV OMPI_MCA_btl_vader_single_copy_mechanism "none"
ENV OMPI_ALLOW_RUN_AS_ROOT 1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM 1

# Set working directory to /usr/local/src
WORKDIR /usr/local/src

## Python installation
RUN curl https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz -O -L \
    && tar zxf Python-3.9.4.tgz \
    && rm -rf Python-3.9.4.tgz \
    && cd Python-3.9.4 \
    && ./configure \
    && make \
    && make altinstall \
    && ln -s /usr/local/bin/python3.9 /usr/local/bin/python \
    && ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip
    ENV PYTHONIOENCODING "utf-8"
    RUN pip install pip -U \
        && pip install \
            numpy \
            scipy \
            matplotlib \
            sympy \
            pandas \
            tqdm \
            Pillow \
            ase \
            joblib \
            Cython \
            fire

RUN cd ..

## Quantum espresso installation
RUN curl https://www.quantum-espresso.org/rdm-download/488/v7-3-1/5a66c1ff456f95c093f28d5f434af978/qe-7.3.1-ReleasePack.tar.gz -O -L
RUN tar xvf qe-7.3.1-ReleasePack.tar.gz \
    && rm -rf qe-7.3.1-ReleasePack.tar.gz
RUN cd qe-7.3.1 \
    && ./configure \
    && make all \
    && make install
