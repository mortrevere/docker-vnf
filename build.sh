#!/bin/bash
appname=$1
docker stop $appname
docker rm $appname
docker build -t $appname $appname
