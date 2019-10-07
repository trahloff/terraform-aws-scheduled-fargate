variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "namespace" {
  description = "Namespace (e.g. `eg` or `cp`)"
  type        = string
  default     = "tf"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
  default     = "test"
}