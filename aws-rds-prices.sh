#!/bin/bash

curl -s https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonRDS/current/region_index.json | jq '.regions | keys' | tr -d '", [, ]'

echo "Type in your region"

read REGION

URL=$(curl -s https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonRDS/current/region_index.json | grep ${REGION} | awk '/currentVersionUrl/ {print $3}' | tr -d '"' | sed 's/json/csv/g')

DT=$(date +%Y-%m-%dT%H%M)

FILE=$(echo "$HOME/aws-prices/${DT}_rds.csv")

[ -d ~/aws-prices ] || mkdir ~/aws-prices

eval touch $(echo $FILE)

curl https://pricing.us-east-1.amazonaws.com{$URL} | grep 'db.t2' > $FILE