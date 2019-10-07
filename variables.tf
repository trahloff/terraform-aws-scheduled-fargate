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