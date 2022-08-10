#!/bin/bash

if [ -z "$1" ] ; then
    echo "usage: $0 [ build | pin Dockerfile | check Dockerfile ]"
    echo   'build' builds the required docker image
    echo   'check' checks the given Dockerfile using the built docker image
    echo Note that the Dockerfile should be in current directory
    exit 1
fi

if [ "$1" == "build" ] ; then
    docker build -t oh2osq/dockpin -f Dockerfile .
elif [ "$1" == "pin" ] ; then
    if [ -z "$2" ] ; then
	echo the Dockerfile argument is empty
	echo usage: $0 pin Dockerfile 
	exit 1
    fi
    docker run -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/tmp --rm -t oh2osq/dockpin docker pin -f /tmp/$2
elif [ "$1" == "check" ] ; then
    if [ -z "$2" ] ; then
	echo the Dockerfile argument is empty
	echo usage: $0 check Dockerfile 
	exit 1
    fi
    docker run -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/tmp --rm -t oh2osq/dockpin docker check -f /tmp/$2
fi

