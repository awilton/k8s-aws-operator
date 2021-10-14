#!/bin/bash
set -ex

ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" | sed -e 's/"//g')
echo "Account id: $ACCOUNT_ID"

_hosted_zone=$(aws route53 list-hosted-zones-by-name --query "HostedZones[?contains(Name, 'tokbox.com')] | [0].Id" | sed -e 's/"\/hostedzone\///' | sed -e 's/"//g')
echo "Hosted zone: $_hosted_zone"

sed -i -e "s/##ACCOUNT_ID##/$ACCOUNT_ID/g" deploy/*
sed -i -e "s/##AWS_REGION##/$AWS_REGION/g" deploy/*
sed -i -e "s/##HOSTED_ZONE##/$_hosted_zone/g" deploy/*

kubectl apply -k config/crd
kubectl apply -f deploy
