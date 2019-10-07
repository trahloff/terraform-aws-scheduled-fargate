locals {
  prefix = "${var.stage}-${var.namespace}-${var.name}"

  common_tags = {
    Namespace = var.namespace
    Stage     = var.stage
    Managed   = "Terraform"
  }
}

##################################################################################################
############################################# Security ###########################################
##################################################################################################

# ECS Executor
# =======================

resource "aws_iam_role" "ecs_execution_role" {
  name               = "${local.prefix}-execution-role"
  assume_role_policy = file("${path.module}/policies/ecs-execution-role.json")
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${local.prefix}-execution-policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

# CloudWatch Scheduler
# =======================

resource "aws_iam_role" "ecs_events" {
  name = "${local.prefix}-scheduler-role"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC
}

resource "aws_iam_role_policy" "ecs_events_run_task_with_any_role" {
  name = "${local.prefix}-scheduler-policy"
  role = "${aws_iam_role.ecs_events.id}"

  policy = <<DOC
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecs:RunTask",
            "Resource": "${replace(aws_ecs_task_definition._.arn, "/:\\d+$/", ":*")}"
        }
    ]
}
DOC
}

##################################################################################################
############################################ ECS Setup ###########################################
##################################################################################################

resource "aws_cloudwatch_log_group" "_" {
  name = "/ecs/${local.prefix}-logs"
}

resource "aws_ecs_cluster" "_" {
  name = "${local.prefix}-cluster"
  tags = local.common_tags
}

##################################################################################################
######################################### Scheduled Task #########################################
##################################################################################################

data "aws_region" "current" {}

data "template_file" "_" {
  template = var.task_definition

  vars = {
    log_region = data.aws_region.current.name
    log_group  = aws_cloudwatch_log_group._.name
  }
}

resource "aws_ecs_task_definition" "_" {
  family                   = local.prefix
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = var.task_role != "" ? var.task_role : ""
  container_definitions    = data.template_file._.rendered
}

resource "aws_cloudwatch_event_rule" "_" {
  name                = "${local.prefix}-run-data-ingress-alliances"
  description         = var.cloudwatch_description
  is_enabled          = var.enabled
  schedule_expression = var.task_schedule_expression
}

resource "aws_cloudwatch_event_target" "_" {
  target_id = local.prefix
  arn       = aws_ecs_cluster._.arn
  rule      = aws_cloudwatch_event_rule._.name
  role_arn  = aws_iam_role.ecs_events.arn

  ecs_target {
    launch_type         = "FARGATE"
    group               = local.prefix
    task_count          = 1
    platform_version    = "LATEST"
    task_definition_arn = aws_ecs_task_definition._.arn

  }
}
