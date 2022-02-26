FROM openkbs/jdk-mvn-py3
#FROM 11.4.1-devel-ubuntu20.04 
#11.4.1-base-ubuntu18.04

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

USER ${USER}
WORKDIR ${HOME}

#### ---- Install some Tensorflow dependencies ----
RUN sudo apt-get update -y && \
    sudo apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libfreetype6-dev \
    libpng-dev \
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
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

#### Graphviz install ####
#temp gpg error fix
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#temp gpg error fix
RUN sudo apt-get update -y
RUN sudo apt-get install -y graphviz

###################################
#### ----   PIP modules: ----  ####
###################################
#### ---- pip3 Package installation ---- ####

COPY requirements.txt ./
ENV PATH="$HOME/.local/bin:$PATH"
RUN sudo python3 -m pip --no-cache-dir install --upgrade pip && \
    sudo python3 -m pip --no-cache-dir install --upgrade setuptools tensorflow && \
    sudo python3 -m pip --no-cache-dir install --ignore-installed notebook && \
    sudo python3 -m pip --no-cache-dir install --ignore-installed -r requirements.txt

RUN sudo python3 -m ipykernel.kernelspec

##################################
#### ----   Virtualenv: ----  ####
##################################

RUN sudo apt-get update -y && \
    sudo apt-get install python3-dev python3-pip && \
    sudo -H pip3 --no-cache-dir install -U virtualenv 
    
#### ---- Ref: https://www.tensorflow.org/install/pip ---- ####
RUN virtualenv --system-site-packages -p python3 ./venv && \
    . ./venv/bin/activate  # sh, bash, ksh, or zsh && \
    pip install --upgrade pip && \
    pip list  # show packages installed within the virtual environment
    
RUN sudo chown -R ${USER}:${USER} ${HOME}

## -- added Local PIP installation bin to PATH
ENV PATH=${PATH}:${HOME}/.local/bin

#### ---- R inside Jupyter ---- ####
#RUN sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common && \
#RUN sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'  && \
RUN sudo apt-get install -y r-base  && \
    sudo apt-get update -y  && \
    sudo apt-get install -y python3-ipykernel

##################################
#### Set up user environments ####
##################################

RUN echo "USER =======> ${USER}"

ENV WORKSPACE=${HOME}/workspace
ENV DATA=${HOME}/data

RUN mkdir -p ${WORKSPACE} ${DATA} 

# Set up our notebook config.
ENV JUPYTER_CONF_DIR=$HOME/.jupyter
COPY ./scripts/jupyter_notebook_config.py ${JUPYTER_CONF_DIR}/

RUN echo "`ls -al ${JUPYTER_CONF_DIR}/*`"

# Copy sample notebooks.
COPY ./notebooks $HOME/sample-notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
ADD ./scripts $HOME/scripts
COPY ./scripts/run_jupyter.sh /run_jupyter.sh

RUN sudo chown -R ${USER}:${USER} $HOME $HOME/.jupyter && \
    sudo chmod +x $HOME/scripts/*.sh /run_jupyter.sh && \
    sudo usermod -aG root $USER && \
    sudo ls -al /usr

#### ---- Spark & PySpark Setup ---- ####
# ref: https://blog.sicara.com/get-started-pyspark-jupyter-guide-tutorial-ae2fe84f594f
# https://www.apache.org/dyn/closer.lua/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
##https://downloads.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz

#ENV SPARK_VERSION=3.0.3
ENV SPARK_VERSION=3.1.2
#
#ENV HADOOP_VERSION=2.7
ENV HADOOP_VERSION=3.2
#
ENV SPARK_DOWN_SITE=https://downloads.apache.org
#ENV SPARK_DOWN_SITE=https://www-us.apache.org/dist
ENV SPARK_HADOOP=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV SPARK_HOME=/opt/spark
ENV PATH=${SPARK_HOME}/bin:$PATH

ENV SPARK_HADOOP_TGZ_URL=${SPARK_DOWN_SITE}/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN wget -q --no-check-certificate ${SPARK_HADOOP_TGZ_URL} && \
    sudo tar -xzf $(basename ${SPARK_HADOOP_TGZ_URL}) -C /opt/ && \
    sudo ln -s /opt/${SPARK_HADOOP} ${SPARK_HOME} && \
    echo "export PYSPARK_DRIVER_PYTHON=jupyter \nexport PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> ${HOME}/.bashrc && \
    rm -f $(basename ${SPARK_HADOOP_TGZ_URL})

#### ---- Jupyter Notebook Extensions ---- ####
RUN pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006
EXPOSE 8888

VOLUME $HOME/data
VOLUME $HOME/workspace
VOLUME $HOME/logs
VOLUME $HOME/notebooks

## ref: https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(Native-GPU-Support)#usage
##
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,video,utility

WORKDIR "$HOME"

#CMD ["/run_jupyter.sh", "notebooks", "--allow-root", "--port=8888", "--ip=0.0.0.0", "--no-browser"]
CMD ["/run_jupyter.sh", "--allow-root"]

