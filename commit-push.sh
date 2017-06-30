#!/bin/bash -x

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

echo "Usage: "
echo "  ${0} <comment> <repo-name/repo-tag>"
echo

imageTag=openkbs/tensorflow-python3-jupyter

comment=${1:-"push ${imageTag}"}

docker ps -a

containerID=`docker ps |grep "${imageTag} "|awk '{print $1}'`
echo "containerID=$containerID"

docker commit -m "$comment" ${containerID} ${imageTag}
docker push ${imageTag}

#docker commit -m "$comment" ${containerID} ${imageTag}
#docker push ${imageTag}


