#!/bin/bash
sudo docker swarm init --advertise-addr=$MANAGER_IP

sudo modprobe mpls_router

while [[ $(sudo docker node ls | awk 'END{print NR}') != $1 ]];
do
    echo "waiting for all worker nodes to join swarm..."
    sleep 10
done
# Create docker registry
sudo docker service create --name registry --publish published=5000,target=5000 registry:2
