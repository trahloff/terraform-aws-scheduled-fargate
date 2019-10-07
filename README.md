# terraform-aws-scheduled-fargate

## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn/releases).

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