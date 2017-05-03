#!/bin/bash
myName=$(basename $0)
source $(dirname $0)/env.sh

echo "${myName} STARTED on $(date '+%F @ %T')"

docker exec -t ${containerName} refresh.sh

echo "${myName}  ENDED  on $(date '+%F @ %T')"
echo ""

exit $?
