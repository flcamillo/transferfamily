# cria um arquivo zip do código da lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/bootstrap"
  output_path = "lambda/bootstrap.zip"
}

# define a lambda para autenticação do usuário SFTP
resource "aws_lambda_function" "lambda_idp" {
  function_name    = var.lambda_idp_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  filename         = "lambda/bootstrap.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  environment {
    variables = {
      ENV_VAR = "value"
    }
  }
}

# define o log group para a lambda do custom idp
resource "aws_cloudwatch_log_group" "lambda_idp" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_idp.function_name}"
  retention_in_days = 7
  tags = {
    ServerName = var.sftp_server_name
  }
}

# define a permissão para o serviço AWS Transfer invocar a lambda
resource "aws_lambda_permission" "lambda_idp_permission" {
  statement_id  = "AllowExecutionFromTransferFamily"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_idp.function_name
  principal     = "transfer.amazonaws.com"
}
