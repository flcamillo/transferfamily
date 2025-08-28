# Descrição

Este projeto utiliza Terraform para provisionar recursos AWS, incluindo funções Lambda escritas em Go para automação de operações com AWS Transfer Family.

## Estrutura

- **Terraform**: Scripts para criar e gerenciar recursos AWS (Transfer Family, Lambda, IAM, S3, KMS, Secrets Manager).
- **Lambda (Go)**: Código fonte da função Lambda em Go, localizado na pasta `lambda`.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.9.5
- [Go](https://golang.org/dl/) >= 1.20
- AWS CLI configurado

## Como usar

1. **Configurar variáveis**
   - Edite o arquivo `variables.tf` conforme necessário.

2. **Build da Lambda**
   ```sh
   cd lambda
   go build -o bootstrap main.go
   ```

3. **Provisionar infraestrutura**
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

## Principais arquivos

- `lambda/main.go`: Código da função Lambda em Go.
- `lambda.tf`: Provisionamento da função Lambda.
- `transfer.tf`: Recursos do AWS Transfer Family.
- `variables.tf`: Variáveis de configuração.
- `s3-upload.tf`, `s3-download.tf`: Permissões S3.

## Observações

- Compile a Lambda para Linux: `GOOS=linux GOARCH=amd64`.
- As permissões e roles estão definidas nos arquivos `*-role.tf