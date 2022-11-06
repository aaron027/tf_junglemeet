resource "aws_dynamodb_table" "terraform-statelock-frontend" {
  name           = "terraform-statelock-frontend"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}