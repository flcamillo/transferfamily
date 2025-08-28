# define a policy de acesso para execução do servidor do transfer family
data "aws_iam_policy_document" "transfer_logging_policy_document" {
  statement {
    sid    = "AllowLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/transfer/*"]
  }
}

# define a policy para execução do servidor do transfer family
resource "aws_iam_policy" "transfer_logging_policy" {
  name        = "transfer-${var.sftp_server_name}-logging-policy"
  description = "Policy for AWS Transfer Family logging"
  policy      = data.aws_iam_policy_document.transfer_logging_policy_document.json
}

# define a policy de confiança para execução do servidor do transfer family
data "aws_iam_policy_document" "transfer_logging_trusted_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

# define a role para execução do servidor do transfer family
resource "aws_iam_role" "transfer_logging_role" {
  name               = "transfer-${var.sftp_server_name}-logging-role"
  assume_role_policy = data.aws_iam_policy_document.transfer_logging_trusted_policy_document.json
}

# associa a policy na role de execução do servidor do transfer family
resource "aws_iam_role_policy_attachment" "transfer_logging_attachment" {
  role       = aws_iam_role.transfer_logging_role.name
  policy_arn = aws_iam_policy.transfer_logging_policy.arn
}
