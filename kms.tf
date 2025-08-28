# Define a chave KMS para criptografia de dados
resource "aws_kms_key" "default" {
  description             = "Chave KMS para criptografia de dados"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

# define a policy para a chave de criptografia KMS
data "aws_iam_policy_document" "kms_key_policy_document" {
  statement {
    sid    = "RootAccountPermissions"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

# Associa a policy na chave KMS
resource "aws_kms_key_policy" "kms_key_policy_attachment" {
  key_id = aws_kms_key.default.id
  policy = data.aws_iam_policy_document.kms_key_policy_document.json
}
