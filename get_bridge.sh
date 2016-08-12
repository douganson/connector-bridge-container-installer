#!/bin/sh

# set -x

IP="`ip route get 8.8.8.8 | awk '{print $NF; exit}'`"
IMAGE="danson/connector-bridge-container-"
TYPE="$1"
SUFFIX=""
DOCKER="`which docker`"

if [ "${TYPE}X" = "X" ]; then
    echo "Usage: $0 [watson | iothub | aws]"
    exit 1
fi

if [ "${TYPE}" = "watson" ]; then
    SUFFIX="iotf"
fi

if [ "${TYPE}" = "iothub" ]; then
    SUFFIX="iothub"
fi

if [ "${TYPE}" = "aws" ]; then
    SUFFIX="awsiot"
fi

if [ "${SUFFIX}X" = "X" ]; then
    echo "Usage: $0 [watson | iothub | aws]"
    exit 2
fi

if [ "${DOCKER}X" = "X" ]; then
    echo "ERROR: docker does not appear to be installed! Please install docker and retry."
    echo "Usage: $0 [watson | iothub | aws]"
    exit 3
fi

if [ "${IP}X" = "X" ]; then
    echo "No IP address was found. Must be connected to the Internet to use."
    echo "Usage: $0 [watson | iothub | aws]"
    exit 4
fi

if [ -x "${DOCKER}" ]; then
    ID=`${DOCKER} ps | grep connector-bridge | awk '{print $1}'`

    if [ "${ID}X" != "X" ]; then
        echo "Stopping $ID"
        docker stop ${ID}
    else
        echo "No running bridge container found... OK"
    fi
    
    if [ "${ID}X" != "X" ]; then
        echo "Removing $ID"
        docker rm --force ${ID}
    fi
    
    echo "Looking for existing container image..."

    ID=`${DOCKER} images | grep connector-bridge | awk '{print $3}'`
    if [ "${ID}X" != "X" ]; then
        echo "Removing Image $ID"
        docker rmi --force ${ID}
    else
        echo "No container image found... (OK)"
    fi

    IMAGE=${IMAGE}${SUFFIX}
    echo ""
    echo "IP Address:" ${IP}
    echo "mbed Connector bridge Image:" ${IMAGE}
    echo "Pulling mbed Connector bridge image from DockerHub(tm)..."
    ${DOCKER} pull ${IMAGE}
    if [ "$?" = "0" ]; then
       echo "Starting mbed Connector bridge image..."
       ${DOCKER} run -d -p ${IP}:8883:8883 -p ${IP}:28519:28519 -p ${IP}:28520:28520 -p ${IP}:22:22 -p ${IP}:8234:8234 -t ${IMAGE}  /home/arm/start_instance.sh
       if [ "$?" = "0" ]; then
           echo "mbed Connector bridge started!  SSH is available to log into the bridge runtime"
	   exit 0
       else
	   echo "mbed Connector bridge FAILED to start!"
           exit 5
       fi
    else 
	echo "mbed Connector docker \"pull\" FAILED!" 
        exit 6
    fi 
else
    echo "ERROR: docker does not appear to be installed! Please install docker and retry."
    echo "Usage: $0 [watson | iothub | aws]"
    exit 3
fi
