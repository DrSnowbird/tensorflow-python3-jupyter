FROM ubuntu:16.04

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

#### ---- Install some Tensorflow dependencies ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    python \
    python3 \
    python3-dev \
    python-pip \
    python3-pip \
    python3-setuptools \
    rsync \
    software-properties-common \
    unzip \
    pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#### ---- pip3 Package installation ----
COPY requirements.txt ./
#RUN pip3 install --upgrade pip && \
RUN pip3 --no-cache-dir install -r requirements.txt && \
    python3 -m ipykernel.kernelspec 

# Install TensorFlow CPU version from central repo
RUN pip3 --no-cache-dir install --upgrade tensorflow

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /
RUN chmod +x /run_jupyter.sh && \
    mkdir /data && \
    mkdir /logs && \
    pip3 install --upgrade pip

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

VOLUME /data
VOLUME /notebooks
VOLUME /logs

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh", "--allow-root"]
