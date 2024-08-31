#!/bin/bash

chmod +x ./${{ env.FILE_NAME }}

./${{ env.FILE_NAME }} &

sleep 5

for LOGIN in Homer Bart Maggie;
do
    echo "$(date): $(curl -s http://localhost:13000/${LOGIN})"
done
