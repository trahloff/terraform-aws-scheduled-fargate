provider "aws" {
  region = var.region
}

module "scheduler" {
  source                   = "../"
  namespace                = var.namespace
  stage                    = var.stage
  
}