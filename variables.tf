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
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}

variable "task_definition" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}

variable "override_definition" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}

variable "name" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = "test"
}

variable "task_cpu" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = number
  default     = 512
}

variable "task_schedule_expression" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
}

variable "task_role" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}

variable "task_group" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = bool
  default = true
}

variable "cloudwatch_description" {
  description = "ECS Cluster ARN. If not set, a new cluster will be created"
  type        = string
  default     = ""
}