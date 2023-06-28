# variables.tf

variable "ecsclustername" {
  description = "The AWS region things are created in"
  default     = "lessons-mgmt-cluster"
}

variable "ecs_taskdefinition" {
  description = "The AWS region things are created in"
  default     = "lessons-mgmt-task"
}

variable "aws_ecs_service_name" {
  description = "The AWS region things are created in"
  default     = "lessons-mgmt-service"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ap-southeast-2"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "lessonsmgmtECSTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "public.ecr.aws/docker/library/tomcat:jdk21-openjdk-slim-bookworm"
}

variable "db_image" {
  description = "Docker image to run in the db cluster"
  default     = "public.ecr.aws/ubuntu/mysql:8.0-20.04_beta"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = "80"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = "2"
}

variable "loggroups" {
  description = "log groups for ecs cluster"
  default     = "app_lessonmgmt_loggroups"
}

variable "db_loggroups" {
  description = "log groups for ecs cluster"
  default     = "db_lessonmgmt_loggroups"
}

variable "logstream" {
  description = "log streams for ecs cluster"
  default     = "lessonmgmt_logstream"
}

variable "health_check_path" {
  default = "/"
}

variable "cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 1024
}

variable "memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 2048
}


####### VPC #########

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr_block" {
  default = "10.0.2.0/24"
}


variable "private_subnet_1_cidr_block" {
  default = "10.0.3.0/24"
}

variable "private_subnet_2_cidr_block" {
  default = "10.0.4.0/24"
}

/*
variable "private_subnet_3_cidr_block" {
  default = ""
}

variable "private_subnet_4_cidr_block" {
  default = ""
}

*/
variable "subnet_az_1" {
  default = "ap-southeast-2a"
}

variable "subnet_az_2" {
  default = "ap-southeast-2b"
}

variable "securitygroupname" {
  default = "lessonsmgmtsg"
}
