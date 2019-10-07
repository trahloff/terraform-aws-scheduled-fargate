variable "namespace" {
  description = "Namespace (e.g. `eg` or `cp`)"
  type        = string
  default     = ""
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
  default     = ""
}