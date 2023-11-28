#!/bin/bash

user=glpi
password=glpi
authtoken=$(echo -n "$user:$password" | base64)
APPTOKEN='i05sner75WB5vffRQXHAuxnf0K5yS5tx1wxGx3L5'
APIURL='http://localhost/glpi/apirest.php'

response=$(curl -s -X GET \
  -H 'Content-Type: application/json' -H "Authorization: Basic $authtoken" \
  -H "App-Token: $APPTOKEN" "$APIURL/initSession")

sessiontoken=$(echo "$response" | grep -o '"session_token":"[^"]*' | sed 's/"session_token":"//')

if [ -n "$sessiontoken" ]; then
  curl -s -X GET \
    -H 'Content-Type: application/json' -H "Session-Token: $sessiontoken" \
    -H "App-Token: $APPTOKEN" "$APIURL/Computer" | jq -r '{all: { hosts: [.[].name]| map(select( . != "ops"))}}'
fi
