#!/usr/bin/env bash

if [ "$#" -ge 1 ]; then
  PROJECT_NAME="$1"
else
  read -p "Nome do projeto: " PROJECT_NAME
fi

# validacao simples do nome do projeto
if [[ ! "$PROJECT_NAME" =~ ^[A-Za-z0-9_-]+$ ]]; then
  echo "Nome inválido. Use somente letras, números, '_' ou '-'"
  exit 1
fi

TEMPLATE_REPO_URL="https://github.com/gritter99/recipes.git"
echo "→ Clonando template de $TEMPLATE_REPO_URL ..."
git clone --depth 1 "$TEMPLATE_REPO_URL" "$PROJECT_NAME"
cd "$PROJECT_NAME"
rm -rf .git

# como fiz o projeto em typescript, o template tem arquivos de configuracao do typescript que preciso remover
rm -rf package.json
rm -rf tsconfig.json
rm -rf jest.config.js
rm -rf src/__tests__/ingredients
rm -rf src/__tests__/recipe
rm -rf src/usecases/ingredient
rm -rf src/usecases/recipe

if [ -d src ]; then
  echo "→ removendo arquivos ts em src/ ..."
  find src -type f -name '*.ts' -delete
fi

# o conteudo do arquivo .gitignore tem que ser substituido por um gitignore de um projeto Python padrao
echo "→ substituindo arquivos a serem ignorados para um projeto python ..."
cat > .gitignore <<'EOF'
__pycache__/
*.py[cod]
*.so
.Python
.env
env/
venv/
ENV/
env.bak/
venv.bak/
pip-log.txt
.coverage
.coverage.*
.cache
EOF

echo "→ criando arquivos __init__.py do projeto..."
touch src/__init__.py
touch src/__tests__/__init__.py
touch src/controllers/__init__.py
touch src/domain/__init__.py
touch src/infra/__init__.py
touch src/infra/repositories/__init__.py
touch src/usecases/__init__.py
touch src/routes/__init__.py
touch src/main.py

cat > src/main.py <<EOF
from fastapi import FastAPI
app = FastAPI(title="API do Projeto $PROJECT_NAME")
@app.get("/")
async def root():
		return {"message": "Hello World - $PROJECT_NAME!"}
@app.get("/health")
async def health():
		return {"status": "ok"}
EOF

echo "→ ajustando arquivo README.md ..."
cat > README.md <<EOF

# Projeto $PROJECT_NAME
====================

Este é um projeto gerado automaticamente.

## Para instalar as dependências, execute:

make install

Para executar os testes, use:

make test

Para verificar o estilo do código, use:

make lint

Para construir a imagem Docker, use:

make build

Para executar o projeto em modo de desenvolvimento, use:

make dev

Para executar o projeto em modo de produção, use:

make run

Para limpar o projeto, use:

make clean

## Estrutura do projeto

src/
├── __init__.py
├── controllers/
│   ├── __init__.py
│   └── <controller_files>.py
├── domain/
│   ├── __init__.py
│   └── <domain_files>.py
├── infra/
│   ├── __init__.py
│   ├── repositories/
│   │   ├── __init__.py
│   │   └── <repository_files>.py
│   └── <infra_files>.py
├── usecases/
│   ├── __init__.py
│   └── <usecase_files>.py
└── main.py
__tests__/
├── __init__.py
├── test_<test_files>.py
Dockerfile
.gitignore
README.md
requirements.txt
Makefile

EOF

echo "→ criando Dockerfile do projeto..."

cat > Dockerfile <<'EOF'
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]
EOF

git init
git config user.name "gritter99"
git config user.email "gabriel.ritter99@hotmail.com"
git add .
git commit -m "✨: estrutura inicial do projeto"


echo "→ Criando virtualenv"
if ! python3 -m venv venv; then
  if command -v apt-get &>/dev/null; then
    echo "→ Instalando pacotes python3-venv e python3-pip via apt-get (vai pedir sudo)..."
    sudo apt-get update
    sudo apt-get install -y python3-venv python3-pip
    echo "→ Re-tentando criar venv"
    if ! python3 -m venv venv; then
      echo "❌ Ainda não foi possível criar o venv após instalar python3-venv."
      exit 1
    fi
  else
    echo "❌ Não foi possível criar um virtualenv automático."
    echo "   Instale 'python3-venv' (Debian/Ubuntu) ou 'virtualenv' e tente novamente."
    exit 1
  fi
fi
source venv/bin/activate

echo "→ Instalando as dependências..."
pip install --upgrade pip || true
pip install fastapi uvicorn[standard] pytest flake8 || {
  echo "❌ Erro ao instalar pacotes. Verifique se está no venv."
  exit 1
}


pip freeze > requirements.txt
git add requirements.txt
git commit -m "✨: adicionando dependencias do projeto"



# makefile com comandos basicos solicitado no exercicio
echo "→ Criando Makefile..."
cat > Makefile <<EOF
.PHONY: install run dev test lint build clean

install:
	@echo "Installing dependencies…"
	@. venv/bin/activate && pip install -r requirements.txt

run:
	@echo "Running FastAPI…"
	@. venv/bin/activate && uvicorn src.main:app

dev:
	@echo "Running in reload mode…"
	@. venv/bin/activate && uvicorn src.main:app --reload

test:
	@echo "Executing tests…"
	@. venv/bin/activate && pytest

lint:
	@echo "Linting with flake8…"
	@. venv/bin/activate && flake8 .

build:
	@echo "Building Docker image…"
	@docker build -t ${PROJECT_NAME}:latest .

clean:
	@echo "Cleaning…"
	@rm -rf src/__pycache__
EOF

git add Makefile
git commit -m "🛠️ adicionando makefile com tasks basicas"

echo "Projeto '$PROJECT_NAME' criado com sucesso!!!"
echo "    → cd $PROJECT_NAME && make install"
