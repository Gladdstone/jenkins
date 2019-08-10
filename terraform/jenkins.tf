data "aws_ami" "jenkins_ami" {
  name_regex  = "CentOS-7-Jenkins*"
  most_recent = true
  owners      = ["self"]
}

resource "aws_iam_role" "jenkins" {
  name = "jenkins-access"

  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}

resource "aws_iam_policy" "jenkins" {
  name        = "jenkins-policy"
  description = "Jenkins execution policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jenkins-attach" {
  role       = "${aws_iam_role.jenkins.name}"
  policy_arn = "${aws_iam_policy.jenkins.arn}"
}

resource "aws_iam_instance_profile" "jenkins-profile" {
  name = "jenkins-profile"
  role = "${aws_iam_role.jenkins.name}"
}

module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.24.0"

  name                   = "jenkins"
  instance_count         = 1

  ami                    = "${data.aws_ami.jenkins_ami.id}"
  instance_type          = "t2.micro"
  key_name               = "joefarrell"
  monitoring             = false
  vpc_security_group_ids = ["${jenkins_sg_id}"]
  subnet_id              = "${jenkins_private_subnets}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}