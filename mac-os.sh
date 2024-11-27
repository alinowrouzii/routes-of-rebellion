#!/bin/bash

# Script to manage routing between two interfaces: en5 (internal) and en0 (external).
# you should find out which interface is internal and which one is external.
# also put the external interface above the internal one in the service order:
# https://support.apple.com/en-bh/guide/mac-help/mchlp2711/mac

# Set variables
INTERFACE_NAME="en5"
DEFAULT_GATEWAY=$(netstat -rn | grep $INTERFACE_NAME | head -n 1 | awk '{print $2}')

# Ensure the default gateway is found
if [ -z "$DEFAULT_GATEWAY" ]; then
  echo "Error: Unable to find the default gateway for interface $INTERFACE_NAME."
  exit 1
fi

echo "Default gateway for $INTERFACE_NAME is $DEFAULT_GATEWAY."

# Define routes
ROUTES=(
  "10.100.0.0/16"
  "192.168.0.0/16"
)

# Add routes
echo "Adding routes through $INTERFACE_NAME..."
for ROUTE in "${ROUTES[@]}"; do
  sudo route -n add -net $ROUTE $DEFAULT_GATEWAY
  if [ $? -eq 0 ]; then
    echo "Route added: $ROUTE via $DEFAULT_GATEWAY"
  else
    echo "Error: Failed to add route for $ROUTE"
  fi
done

# Update /etc/hosts for internal domain resolution
# TODO: Add a mechanism to automate this step.
# Sample logic for adding entries dynamically:
INTERNAL_HOSTS=(
  "chat.service.local 192.168.108.45"
  "internal.service.local 192.168.1.5"
)

echo "Updating /etc/hosts for internal domains..."
for HOST_ENTRY in "${INTERNAL_HOSTS[@]}"; do
  if ! grep -q "${HOST_ENTRY%% *}" /etc/hosts; then
    echo "$HOST_ENTRY" | sudo tee -a /etc/hosts > /dev/null
    echo "Added: $HOST_ENTRY"
  else
    echo "Already exists: ${HOST_ENTRY%% *}"
  fi
done

echo "Routing setup complete."
