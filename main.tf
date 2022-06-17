




# IAM ROLE for Log permissions
resource "aws_iam_role_policy" "Lambda_func_Role" {
  name = "PermsForLambda"
  role = aws_iam_role.iam_for_lambda.id
  policy = file("LambdaPerms.json") # File with permissions
  
}

# IAM ROLE for S3 permissions
resource "aws_iam_role_policy" "s3_role" {
  name = "PermsForS3"
  role = aws_iam_role.iam_for_lambda.id
  policy = file("s3Role.json")
}

resource "aws_lambda_function" "test_lambda" {


  filename      = "lambda_function.zip" # LAMBDA FILES
  function_name = "Lambda"
  role = aws_iam_role.iam_for_lambda.arn # IAM ROLE
  handler       = "lambda_function.lambda_handler" # chooses witch file will run when initiated
 
  runtime          = "python3.9"
  timeout          = "30" 
  memory_size      = 256
  publish          = true

  source_code_hash = filebase64sha256("lambda_function.zip")


  environment {
    variables = {
      foo = "bar"
    }
  }
}
# I made this just to see how API gateway works, it does basically nothing for this project
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test_lambda.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}
