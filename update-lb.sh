#!/bin/ash

# Determine this host's current IP
DST_IP=`curl ifconfig.co`

# Variables passed to us in the env
REPEAT_INTERVAL=${REPEAT_INTERVAL}
WEBHOOK_TOKEN=${WEBHOOK_TOKEN}
FRONTEND_PORT=${FRONTEND_PORT}
BACKEND_PORT=${BACKEND_PORT}
NAME=${NAME}
SEND_PROXY=${SEND_PROXY}

# We allow specifying action as an argument, since we might want to run a "delete" action on shutdown
ACTION=$1

# Allow running the webhook only once, used as an init container
if [ "$REPEAT_INTERVAL" == "once" ]
then
  # Call the hook
  curl \
 -H "Content-Type:application/json" \
 -H "X-Funkypenguin-Token:$WEBHOOK_TOKEN" \
 -X POST \
 -d "{\"dst-ip\":\"$DST_IP\",\"frontend-port\":\"$FRONTEND_PORT\",\"backend-port\":\"$BACKEND_PORT\",\"action\":\"$ACTION\",\"name\":\"$NAME\",\"send-proxy\":\"$SEND_PROXY\"}" \
 $WEBHOOK
else
  while true; do
     # Call the hook
     curl \
  	-H "Content-Type:application/json" \
  	-H "X-Funkypenguin-Token:$WEBHOOK_TOKEN" \
  	-X POST \
  	-d "{\"dst-ip\":\"$DST_IP\",\"frontend-port\":\"$FRONTEND_PORT\",\"backend-port\":\"$BACKEND_PORT\",\"action\":\"$ACTION\",\"name\":\"$NAME\",\"send-proxy\":\"$SEND_PROXY\"}" \
  	$WEBHOOK
     sleep $REPEAT_INTERVAL
  done
fi
