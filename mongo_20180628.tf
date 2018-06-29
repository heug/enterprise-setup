module "mongodb" {
  source                = "./modules/mongodb"
  num_instances         = "3"
  prefix                = "${var.prefix}-"
  cluster_id            = "mongo"
  instance_type         = "${var.services_instance_type}"
  key_name              = "${aws_key_pair.ops.key_name}"
  ami_id                = "${var.mongo_image}"
  az                    = "${element(var.azs, 1)}"
  vpc_id                = "${module.vpc.vpc_id}"
  subnet_id             = "${element(module.vpc.public_subnets, 1)}"
  instance_profile_name = "${module.vpc.circleci_instance_profile_name}"

  security_group_ids = [
    "${aws_security_group.ssh_from_services.id}",
  ]

  ebs_size = "300"
  ebs_iops = "100"
  zone_id  = "${var.ccie_zone}"

  influxdb_url      = "http://metrics.ccie.sc-corp.net:8086"
  influxdb_port     = "8086"
  influxdb_database = "ccie"
}
