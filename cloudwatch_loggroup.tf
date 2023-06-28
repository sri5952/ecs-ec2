# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "lessons-mgmtgroup" {
  name              = var.loggroups
  retention_in_days = 30

  tags = {
    Name = var.loggroups
  }
}

resource "aws_cloudwatch_log_stream" "lessons-mgmtstream" {
  name           = var.logstream
  log_group_name = aws_cloudwatch_log_group.lessons-mgmtgroup.name
}

