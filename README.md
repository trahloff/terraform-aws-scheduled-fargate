# terraform-aws-scheduled-fargate

[![GitHub Tag](https://img.shields.io/github/tag/trahloff/terraform-aws-scheduled-fargate.svg)](https://github.com/trahloff/terraform-aws-scheduled-fargate/releases) [![GitHub Release](https://img.shields.io/github/release/trahloff/terraform-aws-scheduled-fargate.svg)](https://github.com/trahloff/terraform-aws-scheduled-fargate/releases)


## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`).

Straight from `example/`:

```hcl
module "fargate_scheduler" {
  source    = "github.com/trahloff/terraform-aws-scheduled-fargate?ref=master"
  namespace = var.namespace
  stage     = var.stage

  task_definition          = file("${path.module}/definitions/example-task.tpl")
  task_schedule_expression = "rate(1 minute)"
}
```