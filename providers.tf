terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.1"
    }
  }
  backend "s3" {
    #Não dá pra passar variáveis aqui, por isso o hardcoded
    bucket    = "vinicius-state-bucket-tf"
    region  = "us-east-2"
    key     = "terraform.tfstate"
    encrypt = true
    profile = "viniciussilva"
  }

}

provider "aws" {
  profile = "viniciussilva"
}

# Criando recurso para salvar o estado da aplicação
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket

  # camada de seguração para evitar a deleção do nosso bucket ao rodar terraform destroy
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}