##################################################################################################
############################################## Misc ##############################################
##################################################################################################

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

variable "ecs_cluster_id" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}

variable "name" {
  description = "TODO insert variable description"
  type        = string
  default     = "test"
}

variable "enabled" {
  description = "TODO insert variable description"
  type        = bool
  default = true
}

variable "cloudwatch_description" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}

##################################################################################################
############################################## Task ##############################################
##################################################################################################

variable "task_definition" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}

variable "task_override_definition" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}

variable "task_cpu" {
  description = "TODO insert variable description"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "TODO insert variable description"
  type        = number
  default     = 512
}

variable "task_schedule_expression" {
  description = "TODO insert variable description"
  type        = string
}

variable "task_role" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}

variable "task_count" {
  description = "TODO insert variable description"
  type        = number
  default     = 1
}

variable "task_platform_version" {
  description = "TODO insert variable description"
  type        = string
  default     = "LATEST"
}

variable "task_subnets" {
  description = "TODO insert variable description"
  type        = list(string)
  default     = []
}

variable "task_security_groups" {
  description = "TODO insert variable description"
  type        = list(string)
  default     = []
}

variable "task_assign_public_ip" {
  description = "TODO insert variable description"
  type        = bool
  default     = true # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_cannot_pull_image.html
}

variable "task_group" {
  description = "TODO insert variable description"
  type        = string
  default     = ""
}