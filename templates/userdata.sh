#!/bin/bash
#sudo amazon-linux-extras disable docker
#sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs
echo  ECS_CLUSTER="lessons-mgmt-cluster">> /etc/ecs/ecs.config
