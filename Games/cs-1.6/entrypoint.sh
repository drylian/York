#!/bin/bash

# Wait for the container to fully initialize
sleep 1

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1

# Check if the 'installed' file exists 
if [ ! -f "./installed" ]; then
  wget wget https://downloads.csrevo.com/hlds/base/rehlds_full_linux.zip
  unzip rehlds_full_linux.zip .
  cp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so
    # Create the 'installed' file to mark that the installation is complete
    touch ../installed
  fi
  
chmod -R 755 /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
