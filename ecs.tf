# ecs.tf

resource "aws_ecs_cluster" "main" {
  name = var.ecsclustername
}

data "template_file" "lessons-mgmt_app" {
  template = file("./templates/image/image.json")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    cpu    = var.cpu
    memory = var.memory
    aws_region     = var.aws_region
    ecs_taskdefinition = var.ecs_taskdefinition
    loggroups = var.loggroups
    db_image = var.db_image
    db_loggroups = var.db_loggroups
  }
}

data "template_file" "lessons-mgmt_app_userdata" {
  template = file("./templates/userdata.sh")

  vars = {
    ecs_taskdefinition      = var.ecs_taskdefinition
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.ecs_taskdefinition
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = data.template_file.lessons-mgmt_app.rendered
}

resource "aws_ecs_service" "main" {
  name            = var.ecs_taskdefinition
  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "EC2"

  network_configuration {
    security_groups  = [aws_security_group.lessonsmgmt.id]
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    #assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.arn
    container_name   = var.ecs_taskdefinition
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

/*

resource "aws_launch_configuration" "lessonmgmt" {
  name          = "lessonsmgmt"
  image_id                    = "ami-0310483fb2b488153"
  instance_type               = "m4.large"
  key_name                    = "eks"
  security_groups             = [aws_security_group.lessonsmgmt.id]
  user_data                   = data.template_file.lessons-mgmt_app_userdata.rendered
  iam_instance_profile = ecs_task_execution_role.test_profile.arn
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 40
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }
}


resource "aws_autoscaling_group" "bar" {
  name                      = "launchconfig"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = aws_launch_configuration.lessonmgmt.name
  vpc_zone_identifier       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

*/
