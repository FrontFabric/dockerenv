#!/bin/bash

docker rmi $(docker images | grep -v $1 | awk {'print $3'})