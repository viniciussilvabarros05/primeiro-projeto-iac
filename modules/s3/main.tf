# Vamos criar um recurso do s3 bucket
resource "aws_s3_bucket" "bucket" {
    bucket = "${var.s3_bucket_name}-${terraform.workspace}"
    
    #Boa prática colocar tags 
    tags = "${var.s3_tags}"
}

resource "aws_s3_bucket_website_configuration" "bucket" {
    bucket = aws_s3_bucket.bucket.bucket

    index_document{
        suffix = "index.html"


    }

    error_document {
        key = "index.html"
    }

    depends_on = [
        aws_s3_bucket.bucket
    ]
}