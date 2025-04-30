# Documentação do Script generate-git-project.sh

## Objetivo da atividade

O script generate-git-project.sh tem como objetivo automatizar a criação de um novo projeto web api em Python usando um repositório de template (no caso, meu repositório da api de receitas). Ele realiza a configuração inicial do projeto, ajusta arquivos específicos para o contexto de desenvolvimento em Python e prepara o ambiente para desenvolvimento.

Como eu fiz a api de receitas em typescript, tive que fazer alguns ajustes como apagar os arquivos .ts e de configurações node.

### Explicação

1. Entrada de Dados

O script aceita o nome do projeto como argumento ou solicita ao usuário que insira o nome manualmente.
Fiz uma validação simples no nome do projeto para garantir que ele contenha apenas caracteres permitidos (letras, números, \_ ou -).

2. Configuração do Projeto

Cria um arquivo README.md com informações básicas sobre o projeto e instruções de uso.

Gera um Dockerfile para criar uma imagem Docker do projeto. - Achei interessante adicionar até para testar o makefile que criei

Inicializa um novo repositório Git e realiza commits iniciais.

3. Ambiente Virtual

Cria um ambiente virtual Python (venv) e instala dependências básicas como fastapi, uvicorn, pytest e flake8.

Gera um arquivo requirements.txt com as dependências instaladas.

4. Makefile

Como pedido na tarefa, criei um Makefile com comandos úteis para o desenvolvimento, como:
make install: Instalar dependências. - testei e funciona
make run: Executar o projeto. - testei e funciona
make dev: Executar o projeto em modo de desenvolvimento. - testei e funciona
make test: Executar testes. - a ideia é usar o pytest, porem nao adicionei testes no template
make lint: Verificar o estilo do código usando flake8.
make build: Construir a imagem Docker. - adicionei por ser interessante a titulo de desenvolvimento em maquinas diferentes
make clean: Limpar arquivos temporários. - testei e funciona

5. Finalização

Exibe uma mensagem de sucesso com instruções para acessar o diretório do projeto e instalar as dependências.

As fontes utilizadas foram:

[Create and activate a virtual environment on Git Bash](https://stackoverflow.com/questions/56442408/cannot-create-and-activate-a-virtual-environment-on-git-bash-with-python-2-7-wi) - tive mais dificuldade nessa parte

[Bash cheat-sheets](https://kapeli.com/cheat_sheets/Bash_Test_Operators.docset/Contents/Resources/Documents/index) - utilizei para pegar as lógicas de "if" principalmente
