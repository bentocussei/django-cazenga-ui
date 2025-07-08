# 📦 Guia de Publicação no PyPI

Este guia explica como publicar a biblioteca `django-cazenga-ui` no PyPI e como publicar atualizações.

## 📋 Índice

1. [Pré-requisitos](#pré-requisitos)
2. [Primeira Publicação](#primeira-publicação)
3. [Atualizando Versões](#atualizando-versões)
4. [Configuração de Credenciais](#configuração-de-credenciais)
5. [Processo de Build](#processo-de-build)
6. [Publicação](#publicação)
7. [Verificação](#verificação)
8. [Troubleshooting](#troubleshooting)
9. [Melhores Práticas](#melhores-práticas)

---

## 🔧 Pré-requisitos

### Ferramentas Necessárias

```bash
# Instalar ferramentas de build e upload
pip install build twine

# Verificar instalação
python -m build --help
python -m twine --help
```

### Contas PyPI

1. **Criar conta no PyPI**: https://pypi.org/account/register/
2. **Criar token de API**: https://pypi.org/manage/account/token/
3. **Opcional - TestPyPI**: https://test.pypi.org/account/register/

---

## 🚀 Primeira Publicação

### 1. Preparar o Projeto

Certifique-se de que o `pyproject.toml` está configurado corretamente:

```toml
[project]
name = "django-cazenga-ui"
version = "0.1.0"  # Versão inicial
authors = [
    { name="Comunidade Cazenga", email="contato@cazenga.com" },
]
description = "Biblioteca moderna de componentes UI para Django"
readme = "README.md"
license = { text = "MIT" }
requires-python = ">=3.8"
dependencies = [
    "Django>=3.2",
]
```

### 2. Configurar Credenciais

Crie o arquivo `.pypirc` na raiz do projeto:

```ini
[distutils]
index-servers = pypi testpypi

[pypi]
username = __token__
password = pypi-SEU_TOKEN_AQUI

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = SEU_TOKEN_TESTPYPI_AQUI
```

### 3. Construir o Pacote

```bash
# Limpar builds anteriores
rm -rf dist/ build/ *.egg-info/

# Construir o pacote
python -m build
```

### 4. Testar no TestPyPI (Opcional)

```bash
# Upload para TestPyPI
python -m twine upload --repository testpypi dist/*

# Testar instalação
pip install --index-url https://test.pypi.org/simple/ django-cazenga-ui
```

### 5. Publicar no PyPI

```bash
# Upload para PyPI oficial
python -m twine upload dist/*
```

---

## 🔄 Atualizando Versões

### 1. Atualizar Versão

Edite o arquivo `pyproject.toml`:

```toml
[project]
name = "django-cazenga-ui"
version = "0.1.1"  # Nova versão
```

### 2. Atualizar CHANGELOG

Adicione as mudanças no `CHANGELOG.md`:

```markdown
## [0.1.1] - 2024-01-XX

### Adicionado
- Novo componente Modal
- Suporte para tema escuro

### Corrigido
- Bug no componente Button
- Compatibilidade com Django 5.0

### Alterado
- Melhorias na documentação
```

### 3. Fazer Commit das Alterações

```bash
git add .
git commit -m "Bump version to 0.1.1"
git tag v0.1.1
git push origin main --tags
```

### 4. Reconstruir e Publicar

```bash
# Limpar builds anteriores
rm -rf dist/ build/ *.egg-info/

# Construir nova versão
python -m build

# Publicar no PyPI
python -m twine upload dist/*
```

---

## 🔐 Configuração de Credenciais

### Método 1: Arquivo .pypirc (Recomendado)

```ini
[distutils]
index-servers = pypi

[pypi]
username = __token__
password = pypi-SEU_TOKEN_COMPLETO_AQUI
```

### Método 2: Variáveis de Ambiente

```bash
# Windows
set TWINE_USERNAME=__token__
set TWINE_PASSWORD=pypi-SEU_TOKEN_AQUI

# Linux/Mac
export TWINE_USERNAME=__token__
export TWINE_PASSWORD=pypi-SEU_TOKEN_AQUI
```

### Método 3: Linha de Comando

```bash
python -m twine upload dist/* --username __token__ --password pypi-SEU_TOKEN_AQUI
```

---

## 🏗️ Processo de Build

### Verificar Arquivos Incluídos

O arquivo `MANIFEST.in` controla quais arquivos são incluídos:

```ini
include LICENSE.txt
include README.md
recursive-include cazenga_ui/templates_source *.html *.js
recursive-include cazenga_ui/static_source *.css
recursive-include cazenga_ui/templatetags *.py
recursive-include cazenga_ui/management *.py
recursive-include cazenga_ui/utils *.py
global-exclude __pycache__
global-exclude *.py[co]
```

### Comandos de Build

```bash
# Build completo
python -m build

# Apenas wheel
python -m build --wheel

# Apenas source distribution
python -m build --sdist

# Verificar conteúdo do pacote
python -m tarfile -l dist/django-cazenga-ui-0.1.0.tar.gz
```

---

## 📤 Publicação

### Verificar Pacote Antes do Upload

```bash
# Verificar metadados
python -m twine check dist/*

# Verificar estrutura
python -m zipfile -l dist/django_cazenga_ui-0.1.0-py3-none-any.whl
```

### Upload com Verificações

```bash
# Upload com verificação
python -m twine upload --repository testpypi dist/* --verbose

# Upload para produção
python -m twine upload dist/* --verbose
```

---

## ✅ Verificação

### Após a Publicação

1. **Verificar no PyPI**: https://pypi.org/project/django-cazenga-ui/
2. **Testar instalação**:
   ```bash
   pip install django-cazenga-ui
   ```
3. **Verificar importação**:
   ```python
   import cazenga_ui
   print(cazenga_ui.__version__)
   ```

### Métricas de Sucesso

- ✅ Página do projeto acessível
- ✅ Instalação via pip funciona
- ✅ Importação sem erros
- ✅ Dependências resolvidas corretamente

---

## 🚨 Troubleshooting

### Erro 403 Forbidden

```bash
# Causa: Token inválido ou expirado
# Solução: Gerar novo token no PyPI
```

### Erro 400 Bad Request

```bash
# Causa: Versão já existe
# Solução: Incrementar versão no pyproject.toml
```

### Arquivos Ausentes no Pacote

```bash
# Verificar MANIFEST.in
# Reconstruir com python -m build
```

### Dependências Não Resolvidas

```bash
# Verificar [project.dependencies] no pyproject.toml
# Testar em ambiente limpo
```

---

## 📚 Melhores Práticas

### Versionamento Semântico

```
MAJOR.MINOR.PATCH
- MAJOR: Mudanças incompatíveis
- MINOR: Funcionalidades compatíveis
- PATCH: Correções de bugs
```

### Automação com GitHub Actions

```yaml
name: Publish to PyPI
on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: |
          pip install build twine
      - name: Build package
        run: python -m build
      - name: Publish to PyPI
        env:
          TWINE_USERNAME: __token__
          TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
        run: twine upload dist/*
```

### Checklist de Publicação

- [ ] Versão atualizada no `pyproject.toml`
- [ ] CHANGELOG atualizado
- [ ] Testes passando
- [ ] Documentação atualizada
- [ ] Build limpo
- [ ] Verificação com `twine check`
- [ ] Teste no TestPyPI
- [ ] Publicação no PyPI
- [ ] Verificação da instalação
- [ ] Tag Git criada
- [ ] Release no GitHub

---

## 🔗 Links Úteis

- **PyPI**: https://pypi.org/
- **TestPyPI**: https://test.pypi.org/
- **Documentação Twine**: https://twine.readthedocs.io/
- **Documentação Build**: https://build.pypa.io/
- **Especificação pyproject.toml**: https://peps.python.org/pep-0518/

---

## 📧 Suporte

Para dúvidas ou problemas:
- Abra uma issue no GitHub
- Consulte a documentação oficial
- Entre em contato com a comunidade Cazenga

---

**Última atualização**: Janeiro 2024 