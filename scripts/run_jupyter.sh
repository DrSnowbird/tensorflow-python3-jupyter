#!/usr/bin/env bash

env

id
whoami

sudo -H pip3 --no-cache-dir install --ignore-installed -U -r $HOME/requirements-extra.txt

#### ---- OpenSSL Self-Signed Certificate ---- ####
SSL_DIR=$HOME/.cert
SSL_CERT=$SSL_DIR/mycert.pem
SSL_KEY=$SSL_DIR/mykey.key
mkdir -p $SSL_DIR
function setupSSL() {
    ## -- setup certificate
    if [ ! -x ${SSL_CERT} ]; then
        openssl req -x509 -nodes -days 1460 -newkey rsa:2048 -keyout ${SSL_KEY} -out ${SSL_CERT} -batch
    fi
}
setupSSL

sudo chmod -R go+w $HOME/notebooks $HOME/.jupyter
ls -al $HOME
ls -al $HOME/.jupyter/*
ls -al $HOME/notebooks

cd $HOME

tensorboard --logdir $HOME/logs &

# pyspark &

# Install widgets nbextension
#jupyter nbextension enable --py --sys-prefix widgetsnbextension
#jupyter serverextension enable --py jupyterlab --user 
jupyter nbextension enable --py --user widgetsnbextension

#jupyter notebook "$@"

# jupyter notebook --NotebookApp.iopub_data_rate_limit=1.0e10

#### ---- Auto completion ----
#jupyter nbextension install --py jupyter_tabnine --system
#### ---- enable notebook extension and server extension
#jupyter nbextension enable --py --user jupyter_tabnine 
#jupyter serverextension enable --py --user jupyter_tabnine

DATA_RATE_LIMIT=1.0e10
DATA_RATE_ARGS="--NotebookApp.iopub_data_rate_limit=${DATA_RATE_LIMIT}"

ENABLE_HTTPS=`echo $ENABLE_HTTPS |tr '[:upper:]' '[:lower:]'`
if [ "$ENABLE_HTTPS" = "true" ]; then
    jupyter notebook --ip="0.0.0.0" "$@" --certfile=${SSL_CERT} --keyfile=${SSL_KEY} ${DATA_RATE_ARGS}
else
    jupyter notebook --ip="0.0.0.0" "$@" ${DATA_RATE_ARGS}
fi
