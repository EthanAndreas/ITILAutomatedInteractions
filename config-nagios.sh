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
  hosts=$(curl -s -X GET \
    -H 'Content-Type: application/json' -H "Session-Token: $sessiontoken" \
    -H "App-Token: $APPTOKEN" "$APIURL/Computer" | jq -r '.[] | select(.name != "ops") | .name')
  
  echo "" > /etc/nagios4/objects/pc.cfg

  for host in $hosts
  do 
    echo "define host{" >> /etc/nagios4/objects/pc.cfg
    echo "        use                     linux-server" >> /etc/nagios4/objects/pc.cfg
    echo "        host_name               $host" >> /etc/nagios4/objects/pc.cfg
    echo "        check_interval          1" >> /etc/nagios4/objects/pc.cfg
    echo "}" >> /etc/nagios4/objects/pc.cfg
  done
fi

if ! grep -q "cfg_file=/etc/nagios4/objects/pc.cfg" /etc/nagios4/nagios.cfg; then
  echo "cfg_file=/etc/nagios4/objects/pc.cfg" >> /etc/nagios4/nagios.cfg
fi

cat << 'EOF' >> /etc/nagios-plugins/config/smtp.cfg
define command {
    command_name check_smtp
    command_line /home/tprli/check_smtp
}

define service {
    use generic-service
    host_name localhost
    service_description Check SMTP
    check_command check_smtp
    check_interval 1
}
EOF

if ! grep -q "cfg_file=/etc/nagios-plugins/config/smtp.cfg" /etc/nagios4/nagios.cfg; then
  echo "cfg_file=/etc/nagios-plugins/config/smtp.cfg" >> /etc/nagios4/nagios.cfg
fi