resource "aws_autoscaling_group" "netid_autoscaling_group" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4
  launch_template {
    id      = var.launch_template_id
    version = tostring(var.launch_template_version)
  }
}
resource "aws_autoscaling_policy" "netid_autoscaling_policy" {
  name                   = "${var.project_name}-cpu-target-50"
  autoscaling_group_name = aws_autoscaling_group.netid_autoscaling_group.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification { predefined_metric_type = "ASGAverageCPUUtilization" }
    target_value = 50
  }
}