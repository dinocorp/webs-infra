module "this_db" {
  source                              = "../../vendor/xterrafile/aws-aurora"
  name                                = "${var.product}-${var.environment}-mysql"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.12"
  vpc_id                              = var.vpc_id
  subnets                             = var.db_subnets
  replica_count                       = var.db_replica_count
  instance_type                       = var.db_instance_type
  apply_immediately                   = true
  skip_final_snapshot                 = true
  db_parameter_group_name             = aws_db_parameter_group.aurora_db_57_parameter_group.id
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id
  iam_database_authentication_enabled = false
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Product     = var.product
  }
}

resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  name        = "${var.product}-${var.environment}-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${var.product}-${var.environment}-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  name        = "${var.product}-${var.environment}-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${var.product}-${var.environment}-57-cluster-parameter-group"
}

module "this_sg" {
  source = "../../vendor/xterrafile/aws-security-group"

  name   = "${var.product}-${var.environment}-mysql-sg"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = module.this_db.this_rds_cluster_port
      to_port     = module.this_db.this_rds_cluster_port
      protocol    = "tcp"
      description = "MySQL access"
      cidr_blocks = join(",", var.db_subnets)
    },
  ]

  egress_with_self = [
    {
      rule = "all-all"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Product     = var.product
  }
}
