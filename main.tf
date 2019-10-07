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

resource "aws_iam_role" "ecs_execution_role" {
  name               = "${local.prefix}_ecs_execution_role"
  assume_role_policy = file("${path.module}/policies/ecs-execution-role.json")
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${local.prefix}_ecs_autoscale_role_policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

##################################################################################################
############################################ ECS Setup ###########################################
##################################################################################################

resource "aws_cloudwatch_log_group" "_" {
  name = "/ecs/${local.prefix}-logs"
}

resource "aws_ecs_cluster" "_" {
  count = var.ecs_cluster_id == "" ? 1 : 0

  name = "${local.prefix}-cluster"
  tags = local.common_tags
}
