# define o bucket S3
resource "aws_s3_bucket" "upload_bucket" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.upload_bucket_name}"
  tags = {
    Name        = "Uso"
    Environment = "Uso pelos usuários de SFTP"
  }
}

# bloqueia o acesso público ao bucket S3
resource "aws_s3_bucket_public_access_block" "upload_bucket" {
  bucket                  = aws_s3_bucket.upload_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# define o ciclo de vida dos objetos no bucket S3, removendo objetos antigos após os dias especificados
resource "aws_s3_bucket_lifecycle_configuration" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id
  rule {
    id = "remove_old_files"
    filter {
      prefix = ""
    }
    expiration {
      days = 7
    }
    status = "Enabled"
  }
}

# define a policy para permitir apenas acesso com criptograffia
data "aws_iam_policy_document" "upload_bucket_policy_document" {
  statement {
    sid    = "RootAccountPermissions"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "${aws_s3_bucket.upload_bucket.arn}",
      "${aws_s3_bucket.upload_bucket.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

# associa a policy ao bucket S3
resource "aws_s3_bucket_policy" "upload_bucket_policy" {
  bucket = aws_s3_bucket.upload_bucket.id
  policy = data.aws_iam_policy_document.upload_bucket_policy_document.json
}

# define a configuração de criptografia do bucket S3 usando a chave KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "upload_bucket_encryption" {
  bucket = aws_s3_bucket.upload_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.default.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
