#!/bin/bash
source $(dirname $0)/env.sh

docker exec -i -t ${containerName} /bin/bash

exit $?
