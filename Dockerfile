FROM openkbs/jdk-mvn-py3
#FROM ubuntu:16.04

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

##################################
#### Set up user environments ####
##################################

#### ---------------------
#### ---- USER, GROUP ----
#### ---------------------
ENV USER_ID=${USER:-1000}
ENV GROUP_ID=${GROUP:-1000}
ENV USER=developer
ENV HOME=/home/${USER}

RUN groupadd ${USER} && useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} && \
    ## -- Ubuntu -- \
    usermod -aG sudo ${USER} && \
    ## -- Centos -- \
    #usermod -aG wheel ${USER} && \
    echo "${USER} ALL=NOPASSWD:ALL" | tee -a /etc/sudoers && \
    chown ${USER}:${USER} -R ${HOME}
    
RUN echo "USER =======> ${USER}"

USER ${USER}
WORKDIR ${HOME}

ENV WORKSPACE=${HOME}/workspace
ENV DATA=${HOME}/data

RUN echo "USER =======> ${USER}"

RUN mkdir -p ${WORKSPACE} ${DATA} 

# Set up our notebook config.
ENV JUPYTER_CONF_DIR=$HOME/.jupyter
COPY ./scripts/jupyter_notebook_config.py ${JUPYTER_CONF_DIR}/

RUN echo "`ls -al ${JUPYTER_CONF_DIR}/*`"

# Copy sample notebooks.
COPY notebooks $HOME/notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY ./scripts/run_jupyter.sh $HOME/

RUN sudo chown -R ${USER}:${USER} $HOME && chmod +x $HOME/run_jupyter.sh && \
    mkdir $HOME/logs && \
    pip3 install --upgrade pip

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006
EXPOSE 8888

VOLUME $HOME/data
VOLUME $HOME/notebooks
VOLUME $HOME/logs

WORKDIR "$HOME/notebooks"

CMD "$HOME/run_jupyter.sh"
#CMD ["/run_jupyter.sh", "--allow-root"]
