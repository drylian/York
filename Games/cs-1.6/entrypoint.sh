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
  cd /home/container/steamcmd || exit 1

  while test "$status" != "Success! App '90' fully installed."; do 
    status=$(./steamcmd.sh +login anonymous \
    +force_install_dir /home/container +app_update 90 validate +quit | \
    tail -1)
  done

  git clone https://github.com/hpoon/HLDS-CS1.6
  mv -rf ./HLDS-CS1.6/cstrike /home/container/cstrike
  rm -r ./HLDS-CS1.6

  # Create the 'installed' file to mark that the installation is complete
  touch ./installed
  cd /home/container || exit 1
fi

# Replace Startup Variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}