# Pontos a serem avaliados atividade Terraform

- O zip foi implantado via terraform não utilizando recursos deprecated ✅ -> o zip está como Confeite2 porque fiz a alteração de tirar da pasta publish (utilizei a primeira versao do zip enviado). Também fui no painel para alterar a versão .NET para 9.0

- O app service está conectado ao banco via VNET ✅ -> consigo visualizar que estão na mesma vnet em subnets diferentes (portal), porém não consegui validar a rota da documentação

- O banco não está com acesso remote habilitado ✅

- Você utilizou variáveis para valores sensíveis como a senha ✅

- Você utilizou referências para valores mutáveis como o usuário do banco ✅

- Você configurou o seu domínio customizado para a aplicação ✅ -> importei a zona, criei o cname e fiz o binding, porém eu tive literalmente
 que validar o binding no portal apertando um botão, pois aparentemente não da pra fazer isso via terraform nessa versão utilizada

- Você usou o import para conectar ao seu domínio que já está configurado via painel ✅ -> rodei o comando: terraform import azurerm_dns_zone.zona /subscriptions/(id)/resourceGroups/(rg name)/providers/Microsoft.Network/dnsZones/codeforgge.tech; e utilizei a zona de referência criada em dns.tf
