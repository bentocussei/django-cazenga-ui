.PHONY: help clean test coverage lint format install build upload docs

# Configurações padrão
PYTHON := python
PIP := pip
PYTEST := pytest

help: ## Mostra esta ajuda
	@echo "Django Cazenga UI - Comandos disponíveis:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Instalação e setup
install: ## Instala o pacote em modo desenvolvimento
	$(PIP) install -e ".[dev]"

install-tailwind: ## Instala com dependências do Tailwind
	$(PIP) install -e ".[tailwind]"

setup-dev: install ## Configura ambiente de desenvolvimento
	pre-commit install
	@echo "Ambiente de desenvolvimento configurado!"

# Testes
test: ## Executa todos os testes
	$(PYTEST)

test-cov: ## Executa testes com cobertura
	$(PYTEST) --cov=cazenga_ui --cov-report=html --cov-report=term

test-fast: ## Executa testes rápidos (sem os marcados como slow)
	$(PYTEST) -m "not slow"

test-integration: ## Executa apenas testes de integração
	$(PYTEST) -m integration

# Qualidade de código
lint: ## Verifica qualidade do código
	flake8 cazenga_ui/ tests/
	black --check cazenga_ui/ tests/
	isort --check-only cazenga_ui/ tests/

format: ## Formata o código
	black cazenga_ui/ tests/
	isort cazenga_ui/ tests/

security: ## Verifica segurança do código
	bandit -r cazenga_ui/ -f json -o bandit-report.json
	safety check

# Build e publicação
clean: ## Remove arquivos de build
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .coverage
	rm -rf htmlcov/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

build: clean ## Constrói o pacote
	$(PYTHON) -m build

check-build: build ## Verifica o pacote construído
	twine check dist/*

upload-test: build ## Faz upload para TestPyPI
	twine upload --repository testpypi dist/*

upload: build ## Faz upload para PyPI
	twine upload dist/*

# Desenvolvimento
dev-server: ## Inicia servidor de desenvolvimento (se houver projeto de teste)
	@if [ -d "test_project" ]; then \
		cd test_project && python manage.py runserver; \
	else \
		echo "Projeto de teste não encontrado. Execute 'make create-test-project' primeiro."; \
	fi

create-test-project: ## Cria projeto Django de teste
	@if [ ! -d "test_project" ]; then \
		django-admin startproject test_project; \
		cd test_project && python manage.py migrate; \
		echo "Projeto de teste criado em test_project/"; \
	else \
		echo "Projeto de teste já existe."; \
	fi

# Documentação
docs: ## Gera documentação
	@echo "Documentação disponível em README.md e CHANGELOG.md"

# Utilitários
count-components: ## Conta componentes disponíveis
	@echo "Componentes HTML: $$(find cazenga_ui/templates_source/ui -name '*.html' | wc -l)"
	@echo "Arquivos JavaScript: $$(find cazenga_ui/templates_source/js -name '*.js' | wc -l)"
	@echo "Ícones SVG: $$(find cazenga_ui/templates_source/icons -name '*.svg' | wc -l)"

version: ## Mostra versão atual
	@python -c "import configparser; c = configparser.ConfigParser(); c.read('pyproject.toml'); print(c['project']['version'].strip('\"'))"

# CI/CD
ci-test: ## Executa testes como no CI
	$(PYTEST) --cov=cazenga_ui --cov-report=xml
	flake8 cazenga_ui/ tests/
	black --check cazenga_ui/ tests/
	isort --check-only cazenga_ui/ tests/
	bandit -r cazenga_ui/
	safety check

# Comandos específicos do projeto
demo-list: ## Lista componentes usando comando ui
	$(PYTHON) -c "import django; django.setup()" -m cazenga_ui.management.commands.ui list

demo-info: ## Mostra info de um componente (uso: make demo-info COMPONENT=button)
	$(PYTHON) -c "import django; django.setup()" -m cazenga_ui.management.commands.ui info $(COMPONENT)

# Aliases úteis
t: test ## Alias para test
f: format ## Alias para format
l: lint ## Alias para lint
b: build ## Alias para build
c: clean ## Alias para clean 