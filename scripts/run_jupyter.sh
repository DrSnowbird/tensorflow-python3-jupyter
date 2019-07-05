#!/usr/bin/env bash
# MIT License
#
# Copyright (c) 2017 Jeremy Coatelen
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ==============================================================================
env

id
whoami

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

ENABLE_HTTPS=`echo $ENABLE_HTTPS |tr '[:upper:]' '[:lower:]'`
if [ "$ENABLE_HTTPS" = "true" ]; then
    jupyter notebook --ip="0.0.0.0" "$@" --certfile=${SSL_CERT} --keyfile=${SSL_KEY}
else
    jupyter notebook --ip="0.0.0.0" "$@" 
fi
