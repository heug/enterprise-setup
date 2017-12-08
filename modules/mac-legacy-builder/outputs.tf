output "asg_name" {
  value = "${aws_autoscaling_group.mac_asg.name}"
}

output "shutdown_hook_name" {
  value = "${aws_autoscaling_lifecycle_hook.mac_shutdown_hook.name}"
}
