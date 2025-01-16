aws_region = "ap-northeast-1"
vpc_name = "main_apnortheast1"
cidr_numeral = "20"
availability_zones = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
cidr_numeral_public = {
    "0" = "0"
    "1" = "4"
    "3" = "8"
    "4" = "12"
}
cidr_numeral_private_svr = {
    "0" = "24"
    "1" = "28"
    "3" = "32"
#    "4" = "36"
}

cidr_numeral_private_ws = {
    "0" = "48"
    "1" = "52"
    "3" = "60"
#    "4" = "64"
}

cidr_numeral_private_rd = {
    "0" = "72"
    "1" = "80"
    "3" = "88"
#    "4" = "96"
}
