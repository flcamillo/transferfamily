# define a entrada do segredo do usuário SFTP
resource "aws_secretsmanager_secret" "sftp_secret" {
  name                    = "transfer/${var.sftp_server_name}/sftp/users/${var.sftp_user}"
  kms_key_id              = aws_kms_key.default.arn
  recovery_window_in_days = 0
}

# define a policy para o segredo do usuário SFTP
data "aws_iam_policy_document" "secret_manager_policy_document" {
  statement {
    sid       = "RootAccountPermissions"
    effect    = "Allow"
    actions   = ["secretsmanager:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

# associa a policy ao segredo do usuário SFTP
resource "aws_secretsmanager_secret_policy" "secret_manager_policy" {
  secret_arn = aws_secretsmanager_secret.sftp_secret.arn
  policy     = data.aws_iam_policy_document.secret_manager_policy_document.json
}

# define o valor do segredo do usuário SFTP
resource "aws_secretsmanager_secret_version" "sftp_secret" {
  secret_id     = aws_secretsmanager_secret.sftp_secret.id
  secret_string = jsonencode(var.sftp_user_secret)
}
