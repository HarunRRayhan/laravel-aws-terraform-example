resource "aws_launch_template" "lt" {
    name = "${var.app_name}-Launch-Template"

    image_id = data.aws_ami.ubuntu_22_04.id
    instance_type = var.instance_type

    iam_instance_profile {
        arn = aws_iam_instance_profile.ec2_profile.arn
    }

    block_device_mappings {
        device_name = "/dev/sda1"

        ebs {
            volume_size = 20
            volume_type = "gp2"
            delete_on_termination = true
        }
    }

    network_interfaces {
        associate_public_ip_address = true
        delete_on_termination = true
#        security_groups = [var.security_group_id]
    }

    tag_specifications {
        resource_type = "instance"

        tags = {
            Name = "${var.app_name}-Instance"
        }
    }

    user_data = base64encode(templatefile("${path.module}/user_data.sh", {
        APP_NAME = var.app_name
    }))
}


data "aws_ami" "ubuntu_22_04" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name = "${var.app_name}-EC2-Instance-Profile"
    role = aws_iam_role.ec2_profile_role.name
}

resource "aws_iam_role" "ec2_profile_role" {
    name = "${var.app_name}-EC2-Profile-Role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            },
        ]
    })
}

resource "aws_iam_role_policy" "ec_profile_role_policy" {
    name = "${var.app_name}-EC2-Profile-Role-Policy"
    role = aws_iam_role.ec2_profile_role.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "s3:*",
                    "ec2:Describe*",
                ]
                Effect = "Allow"
                Resource = "*"
            },
        ]
    })
}
