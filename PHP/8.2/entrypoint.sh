#!/bin/bash
# time to ensure docker starts completely
sleep 1

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
__PHP_VERSION="82"
php -v

# Run the Server
${MODIFIED_STARTUP}