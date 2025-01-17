# --- Managed Prefix List Create --- #
 # iam
resource "aws_ec2_managed_prefix_list" "iam" {
  name           = "iam.amazoneaws.com-prefix-list"
  address_family = "IPv4"
  max_entries    = 10

  entry {
    cidr = "44.216.198.20/32"
  }

  entry {
    cidr = "44.216.202.179/32"
  }

  entry {
    cidr = "44.216.198.236/32"
  }

  entry {
    cidr = "44.216.186.86/32"
  }

  tags = {
    Name = "iam.amazoneaws.com-prefix-list"
  }
}