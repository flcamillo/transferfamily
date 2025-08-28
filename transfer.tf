# define o servidor do transfer family com protoloco SFTP e autenticação via lambda
resource "aws_transfer_server" "sftp_server" {
  endpoint_type               = "PUBLIC"
  domain                      = "S3"
  protocols                   = ["SFTP"]
  sftp_authentication_methods = "PUBLIC_KEY_AND_PASSWORD"
  host_key                    = var.sftp_key
  identity_provider_type      = "AWS_LAMBDA"
  function                    = aws_lambda_function.lambda_idp.arn
  security_policy_name        = "TransferSecurityPolicy-2024-01"
  logging_role                = aws_iam_role.transfer_logging_role.arn
  protocol_details {
    set_stat_option = "ENABLE_NO_OP"
  }
  tags = {
    Name = var.sftp_server_name
  }
}

# define o log group para o servidor do transfer family
resource "aws_cloudwatch_log_group" "sftp_server" {
  name              = "/aws/transfer/${aws_transfer_server.sftp_server.id}"
  retention_in_days = 7
  tags = {
    ServerName = var.sftp_server_name
  }
}
