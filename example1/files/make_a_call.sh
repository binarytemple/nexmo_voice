#!/bin/bash

test -e 

: ${ NUMBER_FROM        ?"Need to set NUMBER_FROM   "}
: ${ NUMBER_TO          ?"Need to set NUMBER_TO     "}
: ${ ANSWER_URL         ?"Need to set ANSWER_URL    "}

export NUMBER_FROM=${1:?missing first parameter - number from}
export NUMBER_TO  =${2:?missing second parameter - number to}
export ANSWER_URL =${3:-"https://nexmo-community.github.io/ncco-examples/first_call_talk.json"}
export JWT_TOKEN=$(cat ./jwt.token | tr -d '\n')

curl -X POST https://api.nexmo.com/v1/calls \
  -H "Authorization: Bearer $JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"to\":[{\"type\": \"phone\",\"number\": ${NUMBER_TO}}], \"from\": {\"type\": \"phone\",\"number\": ${NUMBER_FROM}}, \"answer_url\":[\"${ANSWER_URL}\"]}"
