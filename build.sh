#!/bin/bash

docker build --tag $REPOSITORY_NAME .
tagging --repository-uri $REPOSITORY_URI --repository-name $REPOSITORY_NAME
