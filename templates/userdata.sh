#!/bin/bash
sudo yum install -y ecs-init
sudo service docker start
sudo service ecs start
echo aws_ecs_cluster="${clustername}">> /etc/ecs/ecs.config
