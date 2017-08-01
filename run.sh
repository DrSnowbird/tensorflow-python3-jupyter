#!/bin/bash -x

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} [<Jupyter_Password>] [<repo-name/repo-tag>] "
    echo "e.g."
    echo "  ${0} password123 openkbs/tensorflow-python3-jupyter"
fi
Password="${JupyterPassword:-password123}"

## -- mostly, don't change this --
baseDataFolder=~/data-docker
MY_IP=`ip route get 1|awk '{print$NF;exit;}'`

function displayPortainerURL() {
    port=${1}
    echo "... Go to: http://${MY_IP}:${port}"
    #firefox http://${MY_IP}:${port} &
    if [ "`which google-chrome`" != "" ]; then 
        /usr/bin/google-chrome http://${MY_IP}:${port} &
    else
        firefox http://${MY_IP}:${port} &
    fi
}

##################################################
#### ---- Mandatory: Change those ----
##################################################
imageTag=${2:-"openkbs/tensorflow-python3-jupyter"}

#PACKAGE=`echo ${imageTag##*/}|tr "/\-: " "_"`
PACKAGE=`echo ${imageTag##*/}|tr "/: " "_"`

#version=cpu

docker_volume_data1=/data
docker_volume_data2=/notebooks
docker_volume_data3=/logs
local_docker_data1=${baseDataFolder}/${PACKAGE}/data
local_docker_data2=${baseDataFolder}/${PACKAGE}/notebooks
local_docker_data3=${baseDataFolder}/${PACKAGE}/logs

#### ---- local data folders on the host ----
mkdir -p ${local_docker_data1}
mkdir -p ${local_docker_data3}
if [ ! -e "${local_docker_data2}" ]; then
    mkdir -p ${local_docker_data2}
    if [ ! -e "${local_docker_data2}/TensorFlow-Examples" ]; then
        cp -r ./notebooks/* ${local_docker_data2}/
        cp -r ./TensorFlow-Examples ${local_docker_data2}/
    fi
fi

#### ---- ports mapping ----
docker_port1=6006
docker_port2=8888

local_docker_port1=26006
local_docker_port2=28888

##################################################
#### ---- Mostly, you don't need change below ----
##################################################
# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
#instanceName=my-${2:-${imageTag##*/}}
instanceName=`echo ${imageTag}|tr "/\-: " "_"`

#### ----- RUN -------
echo "To run: for example"
echo "docker run -d --name ${instanceName} -v ${docker_data}:/${docker_volume_data} ${imageTag}"
echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"

#### ----- Lauch both Python3/Jupyter and TensorBoard ----
## -- Create a container 'notebooks' to run Jupyter Notebook (port 8888) --
#docker run  --name tensorflow-python3 -d -v /$(pwd)/notebooks:/notebooks -v /$(pwd)/logs:/logs -p 8888:8888 dash00/tensorflow-python3-jupyter /run_jupyter.sh --allow-root --NotebookApp.token=''
## -- Create a container 'board' to run Tensorboard (port 6006): --
#docker run  --name board -d -v /$(pwd)/logs:/logs -p 6006:6006 dash00/tensorflow-python3-jupyter tensorboard --logdir /logs
docker run --rm \
    -d \
    --name=${instanceName} \
    -e PASSWORD="${Password}" \
    -p ${local_docker_port1}:${docker_port1} \
    -p ${local_docker_port2}:${docker_port2} \
    -v ${local_docker_data1}:${docker_volume_data1} \
    -v ${local_docker_data2}:${docker_volume_data2} \
    -v ${local_docker_data3}:${docker_volume_data3} \
    ${imageTag}
    
echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"
echo "docker exec -it ${instanceName} /bin/bash"

#### ---- Display IP:Port URL ----
displayPortainerURL ${local_docker_port1}
displayPortainerURL ${local_docker_port2}
