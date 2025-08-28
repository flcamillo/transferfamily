# define a policy de acesso do usuário do transfer family
data "aws_iam_policy_document" "transfer_user_policy_document" {
  statement {
    sid    = "AllowListBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      "${aws_s3_bucket.upload_bucket.arn}",
      "${aws_s3_bucket.download_bucket.arn}"
    ]
  }
  statement {
    sid    = "AllowUploadBucketOperations"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectACL",
      "s3:GetObject",
      "s3:GetObjectACL",
      "s3:GetObjectTagging",
      "s3:GetObjectVersionTagging"
    ]
    resources = [
      "${aws_s3_bucket.upload_bucket.arn}",
      "${aws_s3_bucket.upload_bucket.arn}/*"
    ]
  }
  statement {
    sid    = "AllowDownloadBucketOperations"
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetObjectACL",
      "s3:GetObjectTagging",
      "s3:GetObjectVersionTagging"
    ]
    resources = [
      "${aws_s3_bucket.download_bucket.arn}",
      "${aws_s3_bucket.download_bucket.arn}/*"
    ]
  }
  statement {
    sid    = "AllowKeyPermissions"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GetPublicKey",
      "kms:ListKeyPolicies"
    ]
    resources = [aws_kms_key.default.arn]
  }
}

# define a policy do usuário do transfer family
resource "aws_iam_policy" "transfer_user_policy" {
  name        = "transfer-${var.sftp_server_name}-user-policy"
  description = "Policy for Lambda to access S3 bucket and Secrets Manager"
  policy      = data.aws_iam_policy_document.transfer_user_policy_document.json
}

# define a policy de confiança do usuário do transfer family
data "aws_iam_policy_document" "transfer_user_trusted_policy_document" {
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

# define a role do usuário do transfer family
resource "aws_iam_role" "transfer_user_role" {
  name               = "transfer-${var.sftp_server_name}-user-role"
  assume_role_policy = data.aws_iam_policy_document.transfer_user_trusted_policy_document.json
}

# associa a policy na role do usuário do transfer family
resource "aws_iam_role_policy_attachment" "transfer_user_attachment" {
  role       = aws_iam_role.transfer_user_role.name
  policy_arn = aws_iam_policy.transfer_user_policy.arn
}
