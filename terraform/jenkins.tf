data "aws_ami" "jenkins-ami" {
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
  name        = "test-policy"
  description = "A test policy"

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

resource "aws_instance" "jenkins" {
    ami                  = "${data.aws_ami.jenkins-ami.id}"
    instance_type        = "t1.micro"
    iam_instance_profile = "${aws_iam_instance_profile.jenkins-profile.name}"

    network_interface {
      network_interface_id = "${data.terraform_remote_state.network.jenkins_interface}"
      device_index         = 0
    }
}