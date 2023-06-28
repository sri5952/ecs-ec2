#!/bin/bash
echo  ECS_CLUSTER="lessons-mgmt-cluster">> /etc/ecs/ecs.config
sudo yum install -y ecs-init
sudo service docker start
sudo service ecs start
systemctl enable --now --no-block ecs.service
