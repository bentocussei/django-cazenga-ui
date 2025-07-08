# 🤖 Automação de Publicação no PyPI com CI/CD

Este guia explica como automatizar a publicação da biblioteca `django-cazenga-ui` no PyPI usando GitHub Actions.

## 📋 Índice

1. [Configuração do GitHub Actions](#configuração-do-github-actions)
2. [Secrets do Repositório](#secrets-do-repositório)
3. [Workflows](#workflows)
4. [Automação de Versões](#automação-de-versões)
5. [Testes Automatizados](#testes-automatizados)
6. [Deploy Condicional](#deploy-condicional)

---

## 🔧 Configuração do GitHub Actions

### Estrutura de Pastas

```
.github/
└── workflows/
    ├── publish-pypi.yml
    ├── test.yml
    └── release.yml
```

### Workflow Principal de Publicação

Crie o arquivo `.github/workflows/publish-pypi.yml`:

```yaml
name: Publish to PyPI

on:
  release:
    types: [published]
  workflow_dispatch:
    inputs:
      version:
        description: 'Version to publish'
        required: true
        default: '0.1.0'

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, '3.10', '3.11', '3.12']
        django-version: [3.2, 4.0, 4.1, 4.2, 5.0]
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install Django==${{ matrix.django-version }}
        pip install -r requirements.txt
        pip install pytest pytest-django pytest-cov
    
    - name: Run tests
      run: |
        pytest tests/ --cov=cazenga_ui --cov-report=xml
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml

  build:
    needs: test
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install build dependencies
      run: |
        python -m pip install --upgrade pip
        pip install build twine
    
    - name: Build package
      run: python -m build
    
    - name: Check package
      run: python -m twine check dist/*
    
    - name: Upload build artifacts
      uses: actions/upload-artifact@v3
      with:
        name: dist
        path: dist/

  publish:
    needs: build
    runs-on: ubuntu-latest
    environment: pypi
    
    steps:
    - name: Download build artifacts
      uses: actions/download-artifact@v3
      with:
        name: dist
        path: dist/
    
    - name: Publish to PyPI
      uses: pypa/gh-action-pypi-publish@release/v1
      with:
        user: __token__
        password: ${{ secrets.PYPI_API_TOKEN }}
        repository_url: https://upload.pypi.org/legacy/
```

---

## 🔐 Secrets do Repositório

### Configurar Secrets no GitHub

1. **Acesse**: `Settings > Secrets and variables > Actions`
2. **Adicione os seguintes secrets**:

```
PYPI_API_TOKEN=pypi-SEU_TOKEN_AQUI
TESTPYPI_API_TOKEN=pypi-SEU_TOKEN_TESTPYPI_AQUI
```

### Workflow para TestPyPI

Crie `.github/workflows/test-publish.yml`:

```yaml
name: Test Publish to TestPyPI

on:
  push:
    branches: [ develop, feature/* ]
  pull_request:
    branches: [ main ]

jobs:
  test-publish:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install build twine
    
    - name: Build package
      run: python -m build
    
    - name: Check package
      run: python -m twine check dist/*
    
    - name: Publish to TestPyPI
      if: github.event_name == 'push' && github.ref == 'refs/heads/develop'
      uses: pypa/gh-action-pypi-publish@release/v1
      with:
        user: __token__
        password: ${{ secrets.TESTPYPI_API_TOKEN }}
        repository_url: https://test.pypi.org/legacy/
```

---

## 🏷️ Automação de Versões

### Workflow de Release Automático

Crie `.github/workflows/release.yml`:

```yaml
name: Create Release

on:
  push:
    branches: [ main ]
    paths:
      - 'pyproject.toml'

jobs:
  check-version:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
      tag_exists: ${{ steps.tag_check.outputs.exists }}
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Get version from pyproject.toml
      id: version
      run: |
        VERSION=$(grep -Po '(?<=version = ")[^"]*' pyproject.toml)
        echo "version=$VERSION" >> $GITHUB_OUTPUT
    
    - name: Check if tag exists
      id: tag_check
      run: |
        if git rev-parse "v${{ steps.version.outputs.version }}" >/dev/null 2>&1; then
          echo "exists=true" >> $GITHUB_OUTPUT
        else
          echo "exists=false" >> $GITHUB_OUTPUT
        fi

  create-release:
    needs: check-version
    runs-on: ubuntu-latest
    if: needs.check-version.outputs.tag_exists == 'false'
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Create Release
      uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: v${{ needs.check-version.outputs.version }}
        release_name: Release v${{ needs.check-version.outputs.version }}
        body: |
          ## Changelog
          
          Veja o [CHANGELOG.md](https://github.com/cazenga/django-cazenga-ui/blob/main/CHANGELOG.md) para detalhes.
        draft: false
        prerelease: false
```

---

## 🧪 Testes Automatizados

### Workflow de Testes

Crie `.github/workflows/test.yml`:

```yaml
name: Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, '3.10', '3.11', '3.12']
        django-version: [3.2, 4.0, 4.1, 4.2, 5.0]
        exclude:
          - python-version: 3.8
            django-version: 5.0
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Cache pip
      uses: actions/cache@v3
      with:
        path: ~/.cache/pip
        key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
        restore-keys: |
          ${{ runner.os }}-pip-
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install Django==${{ matrix.django-version }}
        pip install -r requirements.txt
    
    - name: Run tests
      run: |
        python -m pytest tests/ -v --cov=cazenga_ui
    
    - name: Run linting
      run: |
        python -m flake8 cazenga_ui/
        python -m black --check cazenga_ui/
        python -m isort --check-only cazenga_ui/

  docs:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install mkdocs mkdocs-material
    
    - name: Build docs
      run: mkdocs build
```

---

## 🔄 Deploy Condicional

### Workflow com Condições

```yaml
name: Conditional Deploy

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Deploy to PyPI
      # Apenas no push para main
      if: contains(github.event.head_commit.message, '[release]')
      run: |
        echo "Deploying to PyPI..."
        # Comandos de deploy
```

---

## 📝 Scripts Auxiliares

### Script de Bump de Versão

Crie `scripts/bump_version.py`:

```python
#!/usr/bin/env python3
"""
Script para incrementar versão no pyproject.toml
"""

import re
import sys
from pathlib import Path

def bump_version(version_type):
    """Incrementa a versão no pyproject.toml"""
    
    pyproject_path = Path("pyproject.toml")
    content = pyproject_path.read_text()
    
    # Encontrar versão atual
    version_match = re.search(r'version = "([^"]+)"', content)
    if not version_match:
        print("Erro: Não foi possível encontrar a versão")
        sys.exit(1)
    
    current_version = version_match.group(1)
    major, minor, patch = map(int, current_version.split('.'))
    
    # Incrementar versão
    if version_type == 'major':
        major += 1
        minor = 0
        patch = 0
    elif version_type == 'minor':
        minor += 1
        patch = 0
    elif version_type == 'patch':
        patch += 1
    else:
        print("Erro: Tipo de versão inválido (major, minor, patch)")
        sys.exit(1)
    
    new_version = f"{major}.{minor}.{patch}"
    
    # Atualizar arquivo
    new_content = content.replace(
        f'version = "{current_version}"',
        f'version = "{new_version}"'
    )
    
    pyproject_path.write_text(new_content)
    print(f"Versão atualizada: {current_version} → {new_version}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Uso: python bump_version.py <major|minor|patch>")
        sys.exit(1)
    
    bump_version(sys.argv[1])
```

### Makefile para Automação

```makefile
.PHONY: clean build publish test bump-patch bump-minor bump-major

clean:
	rm -rf dist/ build/ *.egg-info/

build: clean
	python -m build

test:
	python -m pytest tests/ -v

publish-test: build
	python -m twine upload --repository testpypi dist/*

publish: build
	python -m twine upload dist/*

bump-patch:
	python scripts/bump_version.py patch
	git add pyproject.toml
	git commit -m "Bump patch version"

bump-minor:
	python scripts/bump_version.py minor
	git add pyproject.toml
	git commit -m "Bump minor version"

bump-major:
	python scripts/bump_version.py major
	git add pyproject.toml
	git commit -m "Bump major version"
```

---

## 🔧 Configuração de Ambiente

### Arquivo de Configuração

Crie `.github/dependabot.yml`:

```yaml
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

### Template de Pull Request

Crie `.github/pull_request_template.md`:

```markdown
## Descrição

Descreva brevemente as mudanças propostas.

## Tipo de Mudança

- [ ] Bug fix (correção que resolve um problema)
- [ ] Nova feature (mudança que adiciona funcionalidade)
- [ ] Breaking change (mudança que quebra compatibilidade)
- [ ] Documentação (apenas mudanças na documentação)

## Checklist

- [ ] Meu código segue as diretrizes do projeto
- [ ] Realizei self-review do código
- [ ] Comentei partes complexas do código
- [ ] Fiz mudanças correspondentes na documentação
- [ ] Minhas mudanças não geram novos warnings
- [ ] Adicionei testes que provam que a correção é efetiva
- [ ] Testes novos e existentes passam localmente
- [ ] Atualizei o CHANGELOG.md
```

---

## 📊 Monitoramento

### Badge para README

Adicione badges ao README.md:

```markdown
![Tests](https://github.com/cazenga/django-cazenga-ui/workflows/Tests/badge.svg)
![PyPI](https://github.com/cazenga/django-cazenga-ui/workflows/Publish%20to%20PyPI/badge.svg)
[![PyPI version](https://badge.fury.io/py/django-cazenga-ui.svg)](https://badge.fury.io/py/django-cazenga-ui)
[![Downloads](https://pepy.tech/badge/django-cazenga-ui)](https://pepy.tech/project/django-cazenga-ui)
[![Python versions](https://img.shields.io/pypi/pyversions/django-cazenga-ui.svg)](https://pypi.org/project/django-cazenga-ui/)
[![Django versions](https://img.shields.io/pypi/djversions/django-cazenga-ui.svg)](https://pypi.org/project/django-cazenga-ui/)
```

---

## 🚀 Comandos Úteis

### Comandos Locais

```bash
# Executar testes
make test

# Incrementar versão e publicar
make bump-patch
git push origin main --tags

# Build e publicação manual
make build
make publish
```

### Comandos do GitHub CLI

```bash
# Criar release
gh release create v0.1.1 --title "Release v0.1.1" --notes "Bug fixes and improvements"

# Executar workflow manualmente
gh workflow run publish-pypi.yml -f version=0.1.1

# Ver status dos workflows
gh run list
```

---

**Última atualização**: Janeiro 2024 