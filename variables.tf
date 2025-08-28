variable "upload_bucket_name" {
  description = "Nome do bucket S3 onde serão gravados os arquivos enviados pelos usuários"
  type        = string
  default     = "sftp-upload"
}

variable "download_bucket_name" {
  description = "Nome do bucket S3 onde estarão os arquivos para download pelos usuários"
  type        = string
  default     = "sftp-download"
}

variable "sftp_server_name" {
  description = "Nome do servidor SFTP"
  type        = string
  default     = "sftp-server-1"
}

variable "lambda_idp_name" {
  description = "Nome da lambda que será responsável pela autenticação do usuário SFTP"
  type        = string
  default     = "lambda-sftp-idp"
}

variable "sftp_key" {
  description = "Privada do Transfer Family para o protocolo SFTP"
  type        = string
  default     = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEAtqR1EjTsKd7kS2f7wYvb9USWqY1KGVmAQ+dtJU83sNk8NmRi\nCS4cLi/CJ4G/J1SXEfi2jGkTYTHW/7uCLN2DyVFBGNL04BlHEx14AH547F5gOa0e\ne3ALlHLipPfSpfUzhfF3oATawzPCKCMe9lWCY3FioBLiAOEn/BbpVwt3bPECnuEz\ntDX7gBYMBxlvG4rs/w8VM72iYDyz1tFI6ffppdFRtc+Fd7TPxKeQFOuXchWH568s\nDprS9tb9F3odA9b8o5NF1Ls7kvdkbQS0QmjnR/WnDBngL2cPH2jUeJGALEpGW6xh\n0eelxnzEBXMJSVPtoxHcpgTfPbrVAk6Um3x/4QIDAQABAoIBAG584o2XEl7qBbVQ\nPE6Dqxae3X3IiVD4gc2STMbLO2dyoyhMZboj+Mw/+/YmWVsToyguC1C5qA2eNvAR\noNg/USASVY0M4TJIWGTJ6PRzjfd/yDpb7hrCV18AePdPLFFVGkwnHTTieuynfQcG\n6A4hAHXj+8PWaH4btzKbMaGEwERYKmAMr4B+euHXPtXJOivb16YxVg/9G4Kb5Ntc\nsjZpVNXGnJl3m75cMm/TjK8QlTyxhgiBSto82hnCGVPqkZpk7Xbnr/dCMMK//FvL\n1wrWX5HRX0rEsxxDb9E2cMbniQKg5atOnFXX8S2qs0yXDgsuTgCB3WsYq9ynzeP0\nabG7/qECgYEAzzJmzaqgEN8MBux7BNWj6kY3eLpJEsOJEiWPWD66FEF7Yctnu27g\n9kPk6vO7Z5X4v5pRdd0wkcgbZO+rwCV96IR1+wEh9xrEes7v+kp7EAk7mLLEacHc\nwohKMUy7PBHTC+1TKJXvPM4hcm92Dy/MM0YIy+WcPq9/j/a7UoRDU40CgYEA4al3\nKPVI0n18OsTkseoe1FIdl5WTOQYMIv6/B9sXiN4braoxuN8grzv958oMHYoC6RDK\nGwFJEA16Kd4KU7F0V3Hf6v8UgievtYkbW+V6cvBA4xJ/vqoKR391gwtyJ62PY5Md\nHB9dCBbzkmuTS5MQeENJASu2hR34QQEtYSypvqUCgYAlEnGObu8A1cfDHWDNdqRD\ncJjQQxR8BPxrgMjrEx4cLbMzxj8jLC2YIoG9ACsR16WQMr5Mhm0ASHuOTcu/L3Yd\nukWZyZQYMHPjPU92ywjFz8EYCzRVb9hd/iC4PXBqyQ2n3qi4ZEtP59nYLdVD1luE\n+Qzt3oFcPe5nBdBybTPWqQKBgQDHXLtMcR8L7xbQqOBOmkLwWzePkvKFH2WbiSnl\n29a38VnMnJ7e8CllBwAzRhpcAnC9zTpwjzsoNm/mCyded1kMZCtp5j8NGdiu7dlA\n38TFRKJeuhonrPv13JJJ2tPYYApc8zx1evPq0LQReH6h9uRHC1K0+RSAGFEZxNt9\njULNjQKBgFNxX4kA1EZ02J/fSWESziY2LyUC2fDDNle6zaamViIhbom8TlEaBrVI\nwNrlItJ9wpKQIm+wzCZKwUe2et4HaJ5gLp6oJtZIKKhqxV4NXjngiOsQ5l0JT14g\nyBtujPtzmtm7Vky9Boxc+YCvsBVW+zUL7XjIbDuZFiArbKrnFrvm\n-----END RSA PRIVATE KEY-----"
}

variable "sftp_user" {
  description = "Nome do usuário SFTP"
  type        = string
  default     = "flc"
}

variable "sftp_user_secret" {
  description = "Credenciais do usuário SFTP"
  type        = map(string)
  default = {
    Username  = "ITAUFA"
    Password  = "$@Sdf1357-ab"
    PublicKey = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEAvIQSs2bGtzR8RB4QAXa75PIhR/yPR4SHAreQeshxCIIZLKnL\n6a2iyg5eISHEIYVhxclt8GohJ+vTe9jdrh43EJyce1roBo0KktdvVVUJcrEurq9E\nw8K96YOj06RC44IxiXHGB6o6FNMolfMjucs27lVul+TDDWIo8vyaXabPnY7zBOx9\nua3wMumSnS3Zrt1w91JW6p1UgI3jkSeDRlmfZDGiNGMvAX9VPDPHnPA8VdRSKZRa\nqw4uyQ3WPbc8Y1022epnHpi07c+MTrW1Kw6B3wsij2mJy4c9Zeteuxv9MRcaGxvH\nTGjLPvnLprruR4FggblM2GPF+4tLF2PnC0id8wIDAQABAoIBAEa+gY4VmakS5zdg\n2LzT4/ss6lRrcRFzqH7aiDurkM+SkwPxzHYrFRYigiyI0WOK/IAO8VTxXvPuSfUG\nE1rON/fh7c9U9BHRSBCHDF7HhL4nw88GMxYLtN0263n3AKsEJrbfnWMu/JDoFSkA\nj32fx0N1iAU0cgZJufhF12Ahw3Pqll2dcezMPS3etRC5wpz/0ejEI7akQKCkm81D\nibuH6elwo2IjueO414G+OoWQ1ZzsL7zC8Aedni1kOmoj2fv2XszXEy8bS1UtNsrU\nlAVphWzYybbz7bihygzQz818zG2hBfKN7suJ0FqOQEaqtfYeZwIsu6atsNZK/p6+\ntbHK2lECgYEA2FiFF/gFP6VIaxRO2qNTe464pUYd+Od4bMz9JA3Hs/Fbw/Eni198\nODahoqhF4UbI6rub8wvvUwncL82pt/lS5eYQRUhaxJSo1LiUX3lm7X35L8xOCDYp\nG3mVUDTuNjEbZApOS7syljzOMMBTRr4CS3vbhbkebDHUZcEhAbeAtw0CgYEA3xG0\n6HMsTUVJsBtxUApTsn5AK9DXImwVRZ24rIyNyGB32Fzuh1jJjzPvfWn2FGJG/9Qz\nb8bIXIRbmcFy4RPUM7tvtboHSWyG9Z+2jMdaEK4dmb8n3Xf6SCjjEm9Qdg4FNWoN\nEWEy6z8D6spPn7Nrlaw0nKN4/BCqCqVLMplJaP8CgYEAk+PvF3N0Iw3Zc1lujgcY\nCl6F2nUUCBIzQCzg3sSMv3U+RbOUVLHxOHwgAhEFs/mvXsbg1ERUVW9oFUWBv0Gw\naXfbp4DOi5MT1lZXFuzmb3Kt5P7EWNitQRrb9vg33tOy5bAl1Z8h9ZGbYbgXNUSu\nTOteJQtmwI9Poj9jUMkgNAECgYB+R/rfQRxKXjg6Dz8VrdL2EEzpwR+ZaBCeyYwb\nerJlRl9ySCHs01G/1Qn2OL9LiNtixtGbrLAO2As3PvF3BA+0fZ7fBQJNCbhZYuIo\nTk7pdHhjanj6AorYwPTTodquCn/eXjwpo5n83T6tc3yiDyOPpt5d8plyMUjiH/Mz\nIN4TJwKBgDN6jVMMGOVF/GQttaWONTfaahBRXVwLPA/X66eGx7jcokkkqmdt+RQ7\nVLLWUMsbc9DECq738GSnsYwzrs1mS0UqcEDjwIrKoa0WQKMrS7moTfChyMeVuOZe\nVWeoYfF5w2S885uV8+l/f3qk1x4iqdIV03L21TdrACid8Q0bsUwc\n-----END RSA PRIVATE KEY-----"
  }
}
