package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// define o evento de autenticação que o servidor do transfer family
// enviará para a lambda
type AwsTransferAutenticationRequest struct {
	UserName string `json:"username"`
	Password string `json:"password"`
	Protocol string `json:"protocol"`
	ServerId string `json:"serverId"`
	SourceIp string `json:"sourceIp"`
}

// define os detalhes do diretório home quando o tipo for LOGICAL
type AwsHomeDirectoryDetails struct {
	Entry  string `json:"Entry"`
	Target string `json:"Target"`
}

// define a resposta que a lambda deve enviar de volta para o servidor do
// transfer family
type AwsTransferAutenticationResponse struct {
	Role                 string   `json:"Role"`
	PosixProfile         string   `json:"PosixProfile,omitempty"`
	PublicKeys           []string `json:"PublicKeys,omitempty"`
	Policy               string   `json:"Policy,omitempty"`
	HomeDirectoryType    string   `json:"HomeDirectoryType,omitempty"`
	HomeDirectoryDetails string   `json:"HomeDirectoryDetails,omitempty"`
	HomeDirectory        string   `json:"HomeDirectory,omitempty"`
}

// ponto de entrada da lambda
func main() {
	lambda.Start(handleRequest)
}

// função que recebe os eventos de autenticação do transfer family
func handleRequest(ctx context.Context, event *AwsTransferAutenticationRequest) (*AwsTransferAutenticationResponse, error) {
	fmt.Printf("user {%s} password {%s} protocol {%s} serverid {%s} sourceip {%s}\n", event.UserName, event.Password, event.Protocol, event.ServerId, event.SourceIp)
	// a estrutura de diretórios virtuais deve ser retornada como um JSON
	// serializado em string
	virtualDirectoryDetails := []*AwsHomeDirectoryDetails{
		{
			Entry:  "/upload",
			Target: "/awsaccount-sftp-upload/${transfer:UserName}",
		},
		{
			Entry:  "/download",
			Target: "/awsaccount-sftp-download/${transfer:UserName}",
		},
	}
	virtualDirectoryData, _ := json.Marshal(virtualDirectoryDetails)
	// define a resposta da autenticação básica
	// esta resposta deve ser adaptada conforme o tipo de autenticação
	response := &AwsTransferAutenticationResponse{
		Role:                 "arn:aws:iam::awsaccount:role/transfer-sftp-server-1-user-role",
		HomeDirectoryType:    "LOGICAL",
		HomeDirectoryDetails: string(virtualDirectoryData),
	}
	// deve sempre retornar a chave pública do usuário quando
	// não é fornecida a senha do usuário
	if event.Password == "" {
		response.PublicKeys = []string{"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwek2fQIlYiIlZ5cwtmw/v7/Z+wVroqTYupvOaEfIv+cc9kGbc1OP6SxUCIvq8bMa28dfE7L+V4v+SmfpPVyteNEQP4noIk4KCz4czYtZNKthbKs3mhSG30DGYP1AoLk02szUGfxJ/o2fl3IhvpLK/KGsL01G9W1KFJ8vf0knRpH2cRVm34VE7JUXU5i7R3K9AdWK2KGZ73ZQPDt0/3pht59+kCrmzD47r8Mq5Cqbq2gwh6+5NNv20Xtiu+l8rtl2lCocRUiXoDEnnTi7yyMkB8y93vj8N/ub04W0FeOtAsaCPBWIK/m77TChIxx/y7Y8lHlwo3v5OQ9b1q389M4jr"}
	}
	data, _ := json.Marshal(response)
	fmt.Printf("response: %s\n", data)
	return response, nil
}
