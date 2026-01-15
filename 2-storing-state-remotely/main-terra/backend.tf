terraform {
    backend "s3" {
        bucket = "beatriz-terraform-state-bucket-2026"
        key = "terraform/terraform.tfstate"
        region = "ap-southeast-2"
        dynamodb_table = "terraform-state-lock"
        encrypt = true
    }   
}