# define a policy de acesso para execução da lambda
data "aws_iam_policy_document" "lambda_execution_policy_document" {
  statement {
    sid    = "AllowLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    sid    = "AllowSecretsManagerAccess"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [aws_secretsmanager_secret.sftp_secret.arn]
  }
  statement {
    sid    = "AllowKeyPermissions"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
    ]
    resources = [aws_kms_key.default.arn]
  }
}

# define a policy para execução da lambda
resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "lambda-${var.lambda_idp_name}-execution-policy"
  description = "Policy for Lambda to access S3 bucket and Secrets Manager"
  policy      = data.aws_iam_policy_document.lambda_execution_policy_document.json
}

# define a policy de confiança para execução da lambda
data "aws_iam_policy_document" "lambda_execution_trusted_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# define a role para execução da lambda
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda-${var.lambda_idp_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_trusted_policy_document.json
}

# associa a policy na role de execução da lambda
resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}
