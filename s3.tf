# Creation of S3 bucket
resource "aws_s3_bucket" "b"{
  bucket = "webxmlstorage" 

  tags = {
    Name        = "SavedWebSites"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}