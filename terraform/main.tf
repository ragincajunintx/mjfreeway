provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.aws_region

    version = "~> 2.0"
}

resource "aws_ecr_repository" "helloworld_react" {
    name = "app"
    image_scanning_configuration {
        scan_on_push = true
    }
    provisioner "local-exec" {
        command = "echo ${aws_ecr_repository.helloworld_react.repository_url} > ECRURL.txt"
    }
}

