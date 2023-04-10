resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "Hello ${count.index}"
  }
}
# ------------------------------------------------------
# resource "aws_iam_role_policy" "ec2_policy" {
#   name = "ec2_policy"
#   role = "${aws_iam_role.ec2_role.id}"
#   # policy = "${file("ec2-policy.json")}"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }


# resource "aws_iam_role" "ec2_role" {
#   name = "ec2_role"
#   # assume_role_policy = "${file("ec2-assume-policy.json")}
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

# }

# resource "aws_iam_instance_profile" "ec2_profile" {
#   name = "ec2_profile"
#   role = "${aws_iam_role.ec2_role.name}"
# }
# -------------------------------------------------------

resource "aws_iam_role" "ec2_role" {
name = "ec2-role"
assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Action = "sts:AssumeRole"
Effect = "Allow"
Principal = {
Service = "ec2.amazonaws.com"
}
}
]
})
}

# Inline policy
resource "aws_iam_role_policy" "inline_policy" {
name = "ec2_-role-inline-policy"
role = "${aws_iam_role.ec2_role.id}"

policy = jsonencode({
Version = "2012-10-17"
Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


# Managed policy
resource "aws_iam_policy_attachment" "managed_policy" {
name = "ec2-role-managed-policy"
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
roles = [aws_iam_role.ec2_role.id]
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}