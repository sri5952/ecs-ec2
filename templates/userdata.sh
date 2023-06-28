#!/bin/bash
sudo amazon-linux-extras disable docker
sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs
echo aws_ecs_cluster="${clustername}">> /etc/ecs/ecs.config
