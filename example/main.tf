provider "aws" {
  region = var.region
}

module "scheduler" {
  source    = "../"
  namespace = var.namespace
  stage     = var.stage

  task_definition          = file("${path.module}/definitions/example-task.tpl")
  task_schedule_expression = "rate(1 minute)"
}
