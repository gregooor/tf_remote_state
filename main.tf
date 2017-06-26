provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "remote_state" {
  bucket = "${var.prefix}-remote-state-${var.environment}"
  acl    = "authenticated-read"

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.prefix}-remote_state-${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_dynamodb_table" "tf_lock_table" {
  name           = "${var.prefix}-remote-state-${var.environment}-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name        = "${var.prefix}-remote-state-${var.environment}-lock"
    Environment = "${var.environment}"
  }
}
