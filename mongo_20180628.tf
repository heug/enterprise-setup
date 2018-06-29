module "mongodb" {
  source                = "./modules/mongodb"
  num_instances         = "3"
  prefix                = "${var.prefix}-"
  cluster_id            = "mongo"
  instance_type         = "${var.mongo_instance_type}"
  key_name              = "${var.aws_ssh_key_name}"
  ami_id                = "${var.mongo_image}"
  # TODO: Does AZ need to be specified?
  # az                    = "${element(var.azs, 1)}"
  vpc_id                = "${var.aws_vpc_id}"
  # TODO: Do public subnets need to be specified?
  # subnet_id             = "${element(module.vpc.public_subnets, 1)}"
  instance_profile_name = "${var.prefix}_instance_profile"

  security_group_ids = [
    "${aws_security_group.ssh_from_services.id}",
  ]

  ebs_size = "300"
  ebs_iops = "100"
  zone_id  = "${var.ccie_zone}"

  # influxdb_url      = "http://metrics.ccie.sc-corp.net:8086"
  # influxdb_port     = "8086"
  # influxdb_database = "ccie"
}
