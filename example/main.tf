provider "aws" {
  region = var.region
}

module "scheduler" {
  source                   = "../"
  namespace                = var.namespace
  stage                    = var.stage

  task_definition = file("${path.module}/definitions/example-task.tpl")
  override_definition = file("${path.module}/definitions/override_example.json")
}