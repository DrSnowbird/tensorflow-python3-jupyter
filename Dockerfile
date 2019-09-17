FROM openkbs/jdk-mvn-py3
#FROM ubuntu:16.04

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

USER ${USER}
WORKDIR ${HOME}

#### ---- Install some Tensorflow dependencies ----
RUN sudo apt-get update && \
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

###################################
#### ----   PIP modules: ----  ####
###################################
#### ---- pip3 Package installation ---- ####
COPY requirements.txt ./

RUN sudo -H pip3 --no-cache-dir install --upgrade setuptools && \
    sudo -H pip3 --no-cache-dir install --ignore-installed -U -r requirements.txt
RUN sudo -H pip3 --no-cache-dir install -U matplotlib && \
    sudo -H pip3 --no-cache-dir install --ignore-installed notebook && \
    sudo python3 -m ipykernel.kernelspec && \
    sudo pip --no-cache-dir install --upgrade pip && \
    sudo pip3 --no-cache-dir install --upgrade pip 

##################################
#### ----   Tensorflow: ----  ####
##################################

#### ---- Install TensorFlow CPU version from central repo ---- ####
RUN sudo -H pip3 --no-cache-dir install --upgrade setuptools && \
    sudo -H pip3 --no-cache-dir install --upgrade tensorflow && \
    python3 -c "import tensorflow as tf; print('TensorFlow version {} is installed.'.format(tf.VERSION))" && \
    python3 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"

# system-wide install
RUN sudo apt update -y && \
    sudo apt install python3-dev python3-pip && \
    sudo -H pip3 --no-cache-dir install -U virtualenv 
    
#### ---- Ref: https://www.tensorflow.org/install/pip ---- ####
RUN virtualenv --system-site-packages -p python3 ./venv && \
    . ./venv/bin/activate  # sh, bash, ksh, or zsh && \
    pip install --upgrade pip && \
    pip list  # show packages installed within the virtual environment
    
RUN sudo chown -R ${USER}:${USER} ${HOME}

## -- added Local PIP installation bin to PATH
ENV PATH=${PATH}:${HOME}/.local/bin

##################################
#### Set up user environments ####
##################################

RUN echo "USER =======> ${USER}"

ENV WORKSPACE=${HOME}/workspace
ENV DATA=${HOME}/data

RUN echo "USER =======> ${USER}"

RUN mkdir -p ${WORKSPACE} ${DATA} 

# Set up our notebook config.
ENV JUPYTER_CONF_DIR=$HOME/.jupyter
COPY ./scripts/jupyter_notebook_config.py ${JUPYTER_CONF_DIR}/

RUN echo "`ls -al ${JUPYTER_CONF_DIR}/*`"

# Copy sample notebooks.
COPY notebooks $HOME/sample-notebooks

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
#
ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.7
ENV SPARK_HADOOP=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV SPARK_HOME=/opt/spark
ENV PATH=${SPARK_HOME}/bin:$PATH

# https://www-us.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
# https://www.apache.org/dyn/closer.lua/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
ENV SPARK_HADOOP_TGZ_URL=https://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN wget -q ${SPARK_HADOOP_TGZ_URL} && \
    sudo tar -xzf $(basename ${SPARK_HADOOP_TGZ_URL}) -C /opt/ && \
    sudo ln -s /opt/${SPARK_HADOOP} ${SPARK_HOME} && \
    echo "export PYSPARK_DRIVER_PYTHON=jupyter \nexport PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> ${HOME}/.bashrc && \
    rm -f $(basename ${SPARK_HADOOP_TGZ_URL})

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006
EXPOSE 8888

VOLUME $HOME/data
VOLUME $HOME/workspace
VOLUME $HOME/logs
VOLUME $HOME/notebooks

WORKDIR "$HOME"

#CMD ["/run_jupyter.sh"]
CMD ["/run_jupyter.sh", "--allow-root"]
