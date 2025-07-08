# ✅ Checklist de Publicação no PyPI

Este é um checklist prático para publicar novas versões da biblioteca `django-cazenga-ui` no PyPI.

## 📋 Checklist Pré-Publicação

### 🔍 Verificações Iniciais
- [ ] Código revisado e aprovado
- [ ] Todos os testes passando
- [ ] Documentação atualizada
- [ ] CHANGELOG.md atualizado
- [ ] Versão incrementada no `pyproject.toml`

### 🧪 Testes Locais
- [ ] Testes unitários executados: `pytest tests/`
- [ ] Testes de integração passando
- [ ] Linting sem erros: `flake8 cazenga_ui/`
- [ ] Formatação verificada: `black --check cazenga_ui/`
- [ ] Imports organizados: `isort --check-only cazenga_ui/`

### 📦 Build e Verificação
- [ ] Build executado: `python -m build`
- [ ] Pacotes verificados: `python -m twine check dist/*`
- [ ] Conteúdo do pacote conferido
- [ ] Dependências corretas no `pyproject.toml`

---

## 🚀 Checklist de Publicação

### 📤 Publicação TestPyPI (Opcional)
- [ ] Upload para TestPyPI: `python -m twine upload --repository testpypi dist/*`
- [ ] Instalação testada: `pip install --index-url https://test.pypi.org/simple/ django-cazenga-ui`
- [ ] Funcionalidade básica testada
- [ ] Importações funcionando

### 📤 Publicação PyPI Oficial
- [ ] Upload para PyPI: `python -m twine upload dist/*`
- [ ] Página do PyPI verificada: https://pypi.org/project/django-cazenga-ui/
- [ ] Instalação via pip testada: `pip install django-cazenga-ui`
- [ ] Versão correta exibida

### 🏷️ Versionamento Git
- [ ] Commit das alterações: `git commit -m "Bump version to X.X.X"`
- [ ] Tag criada: `git tag vX.X.X`
- [ ] Push para repositório: `git push origin main --tags`
- [ ] Release criado no GitHub

---

## 🔧 Comandos Rápidos

### Preparação
```bash
# Limpar builds anteriores
rm -rf dist/ build/ *.egg-info/

# Executar testes
pytest tests/ -v

# Verificar código
flake8 cazenga_ui/
black --check cazenga_ui/
isort --check-only cazenga_ui/
```

### Build
```bash
# Construir pacote
python -m build

# Verificar pacote
python -m twine check dist/*
```

### Publicação
```bash
# TestPyPI (opcional)
python -m twine upload --repository testpypi dist/*

# PyPI oficial
python -m twine upload dist/*
```

### Git
```bash
# Versionar
git add .
git commit -m "Bump version to X.X.X"
git tag vX.X.X
git push origin main --tags
```

---

## 📝 Templates de Commit

### Bump de Versão
```
Bump version to X.X.X

Changes:
- Feature: Nova funcionalidade
- Fix: Correção de bug
- Docs: Melhoria na documentação
```

### Release Notes
```
Release vX.X.X

## Added
- Novo componente Modal
- Suporte para Django 5.0

## Fixed
- Bug no componente Button
- Problema de compatibilidade

## Changed
- Melhoria na performance
- Atualização de dependências

## Removed
- Componente depreciado
```

---

## 🚨 Troubleshooting Comum

### Erro 403 Forbidden
```bash
# Verificar token
cat .pypirc

# Gerar novo token no PyPI
# Atualizar .pypirc
```

### Erro 400 Bad Request
```bash
# Verificar se versão já existe
# Incrementar versão no pyproject.toml
```

### Pacote Incompleto
```bash
# Verificar MANIFEST.in
# Reconstruir: python -m build
```

### Dependências Não Encontradas
```bash
# Verificar requirements em pyproject.toml
# Testar em ambiente limpo
```

---

## 📊 Checklist Pós-Publicação

### ✅ Verificação Imediata
- [ ] Página do PyPI acessível
- [ ] Instalação funcionando: `pip install django-cazenga-ui`
- [ ] Importação sem erros: `import cazenga_ui`
- [ ] Versão correta: `cazenga_ui.__version__`

### 📢 Comunicação
- [ ] Anúncio no GitHub Discussions
- [ ] Tweet ou post em redes sociais
- [ ] Atualização no README principal
- [ ] Documentação de release notes

### 🔄 Manutenção
- [ ] Monitorar issues relacionadas à nova versão
- [ ] Verificar métricas de download
- [ ] Planejar próxima versão
- [ ] Atualizar roadmap do projeto

---

## 📋 Exemplo de Fluxo Completo

### Versão Patch (0.1.0 → 0.1.1)
```bash
# 1. Preparar
rm -rf dist/ build/ *.egg-info/
pytest tests/ -v

# 2. Versionar
# Editar pyproject.toml: version = "0.1.1"
# Atualizar CHANGELOG.md

# 3. Build
python -m build
python -m twine check dist/*

# 4. Publicar
python -m twine upload dist/*

# 5. Git
git add .
git commit -m "Bump version to 0.1.1"
git tag v0.1.1
git push origin main --tags
```

### Versão Minor (0.1.1 → 0.2.0)
```bash
# Mesmo processo, mas com:
# - Testes mais extensivos
# - Documentação de breaking changes
# - Comunicação ampla para usuários
```

### Versão Major (0.2.0 → 1.0.0)
```bash
# Processo completo com:
# - Review de segurança
# - Testes em múltiplas versões
# - Plano de migração
# - Documentação de breaking changes
```

---

## 🎯 Automação Futura

### GitHub Actions
- [ ] Workflow de build automático
- [ ] Testes em múltiplas versões
- [ ] Publicação automática em releases
- [ ] Verificação de qualidade de código

### Scripts Auxiliares
- [ ] Script de bump de versão
- [ ] Script de build e verificação
- [ ] Script de limpeza
- [ ] Script de publicação completa

---

## 📚 Referências Rápidas

### Versionamento Semântico
- **PATCH** (0.1.0 → 0.1.1): Bug fixes
- **MINOR** (0.1.1 → 0.2.0): New features
- **MAJOR** (0.2.0 → 1.0.0): Breaking changes

### Links Úteis
- [PyPI](https://pypi.org/project/django-cazenga-ui/)
- [TestPyPI](https://test.pypi.org/project/django-cazenga-ui/)
- [GitHub Releases](https://github.com/cazenga/django-cazenga-ui/releases)
- [Documentação Twine](https://twine.readthedocs.io/)

---

**Salve este checklist e use-o em todas as publicações!**

**Última atualização**: Janeiro 2024 