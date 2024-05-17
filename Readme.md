# Penetration Testing with Robot Framework

Este repositório contém scripts de teste para realizar testes de penetração básicos em um endpoint de login usando o Robot Framework e a RequestsLibrary.

## Pré-requisitos

Antes de executar os testes, certifique-se de ter os seguintes componentes instalados:

- Python 3.6 ou superior
- Robot Framework
- RequestsLibrary

### Instalação

1. Clone o repositório:

   ```sh
   git clone https://github.com/seu-usuario/repo-teste-penetracao.git
   cd repo-teste-penetracao


```bash
    pip install robotframework
    pip install robotframework-requests
```

```bash
AlltTest/
│
├── pentest.robot          # Script de teste principal
├── README.md              # Documentação do projeto
└── requirements.txt       # Arquivo de dependências (opcional)
```

### Exemplos de LOG

```bash
    Send Valid Login Request :: Enviar uma requisição de login válida ... | PASS |
    ------------------------------------------------------------------------------
    Test Weak Password :: Verificar se a API aceita uma senha comum/fr... | FAIL |
    HTTPError: 400 Client Error: Bad Request for url: https://develop.qacoders-academy.com.br/api/login/
    ------------------------------------------------------------------------------
    Test SQL Injection :: Verificar se a API é vulnerável a SQL Inject... | FAIL |
    HTTPError: 400 Client Error: Bad Request for url: https://develop.qacoders-academy.com.br/api/login/
    ------------------------------------------------------------------------------
    Test Brute Force Protection :: Simular tentativas de login com vár... | FAIL |
    HTTPError: 400 Client Error: Bad Request for url: https://develop.qacoders-academy.com.br/api/login/

```


### Execuçao

Modo de executar

1.  robot -d .\Results .\Security.robot