
resource "aws_s3_bucket" "this" {
  bucket = "${var.tags.Name}-${var.name_suffix}"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning
  }
}


# Policy to allow an EC2 instance to access the bucket.
resource "aws_iam_role_policy" "concrexit-iam-role-policy" {
  name   = "${var.tags.Name}-${var.name_suffix}-policy"
  role   = var.ec2_role_id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.this.arn}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["${aws_s3_bucket.this.arn}/*"]
    }
  ]
}
EOF
}
