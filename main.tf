locals {
  prefix = "${var.stage}-${var.namespace}"

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
  name               = "${local.prefix}-${var.name}-execution-role"
  assume_role_policy = file("${path.module}/policies/ecs-execution-role.json")
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${local.prefix}-${var.name}-execution-policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

# CloudWatch Scheduler
# =======================

resource "aws_iam_role" "ecs_events" {
  name = "${local.prefix}-${var.name}-scheduler-role"

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
  name = "${local.prefix}-${var.name}-scheduler-policy"
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
  count = var.ecs_cluster_id == "" ? 1 : 0

  name = "${local.prefix}-${var.name}-cluster"
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
  family                   = "${local.prefix}-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  # task_role_arn            = module.fargate.ecs_task_role_arn
  container_definitions    = data.template_file._.rendered
}


# // ALLIANCES INGRESS
# // ========================

# resource "aws_cloudwatch_event_rule" "run_data_ingress_alliances" {
#   name        = "${local.prefix}-run-data-ingress-alliances"
#   description = "start data ingress"
#   is_enabled  = true //   var.data_ingress_schedule_enabled
#   schedule_expression = "cron(0 5 * * ? *)" // 5AM UTC --> 7AM UTC
#   # schedule_expression = "rate(1 minute)"
# }

# resource "aws_cloudwatch_event_target" "scheduled_data_ingress_alliances" {
#   target_id = "${local.prefix}-data-ingress-target-alliances"
#   arn       = module.fargate.ecs_cluster_id
#   rule      = aws_cloudwatch_event_rule.run_data_ingress_alliances.name
#   role_arn  = aws_iam_role.ecs_events.arn
#   input     = file("${path.module}/definitions/override_alliances.json")

#   ecs_target {
#     launch_type         = "FARGATE"
#     group               = "TOOLS"
#     task_count          = 1
#     platform_version    = "LATEST"
#     task_definition_arn = aws_ecs_task_definition.data_ingress.arn

#     network_configuration {
#       subnets = data.aws_subnet_ids.private.ids
#     }
#   }

# }
