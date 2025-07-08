# Contribuindo para Django Cazenga UI

Obrigado por seu interesse em contribuir para o Django Cazenga UI! 🎉

## Como Contribuir

### Reportando Bugs

1. **Verifique se o bug já foi reportado** nos [Issues do GitHub](https://github.com/cazenga/django-cazenga-ui/issues)
2. **Crie um novo issue** se não encontrar um existente
3. **Use o template de bug report** e forneça:
   - Descrição clara do problema
   - Passos para reproduzir
   - Comportamento esperado vs atual
   - Versões do Python, Django e dependências
   - Screenshots se aplicável

### Sugerindo Melhorias

1. **Abra um issue** com label `enhancement`
2. **Descreva claramente** a melhoria proposta
3. **Explique por que** seria útil para outros usuários
4. **Considere a compatibilidade** com versões suportadas

### Contribuindo com Código

#### Configuração do Ambiente de Desenvolvimento

1. **Fork o repositório**
2. **Clone seu fork**:
   ```bash
   git clone https://github.com/SEU-USERNAME/django-cazenga-ui.git
   cd django-cazenga-ui
   ```

3. **Crie um ambiente virtual**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate     # Windows
   ```

4. **Instale dependências de desenvolvimento**:
   ```bash
   pip install -e ".[dev]"
   ```

5. **Configure pre-commit hooks** (opcional):
   ```bash
   pip install pre-commit
   pre-commit install
   ```

#### Fluxo de Trabalho

1. **Crie uma branch** para sua feature/fix:
   ```bash
   git checkout -b feature/nome-da-feature
   # ou
   git checkout -b fix/nome-do-bug
   ```

2. **Faça suas alterações**

3. **Execute os testes**:
   ```bash
   pytest
   ```

4. **Verifique a qualidade do código**:
   ```bash
   black cazenga_ui/ tests/
   isort cazenga_ui/ tests/
   flake8 cazenga_ui/ tests/
   ```

5. **Commit suas mudanças**:
   ```bash
   git add .
   git commit -m "feat: adiciona componente X"
   ```

6. **Push para seu fork**:
   ```bash
   git push origin feature/nome-da-feature
   ```

7. **Abra um Pull Request**

#### Convenções de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` para novas funcionalidades
- `fix:` para correções de bugs
- `docs:` para mudanças na documentação
- `style:` para formatação, sem mudanças no código
- `refactor:` para refatoração sem mudanças funcionais
- `test:` para adicionar ou corrigir testes
- `chore:` para tarefas de manutenção

Exemplos:
```
feat: adiciona componente DataTable
fix: corrige problema de layout no Safari
docs: atualiza README com novos exemplos
test: adiciona testes para comando ui icons
```

#### Padrões de Código

- **Python**: Seguimos PEP 8
- **Formatação**: Usamos `black` com linha de 88 caracteres
- **Imports**: Organizados com `isort`
- **Linting**: Verificado com `flake8`

#### Estrutura de Arquivos

```
cazenga_ui/
├── management/
│   └── commands/          # Comandos CLI
├── templates_source/
│   ├── ui/               # Componentes HTML
│   ├── js/               # Arquivos JavaScript
│   └── icons/            # Ícones SVG
├── static_source/
│   └── css/              # Arquivos CSS
├── templatetags/         # Template tags Django
└── utils/                # Utilitários e registro
```

### Adicionando Novos Componentes

1. **Crie o arquivo HTML** em `cazenga_ui/templates_source/ui/`
2. **Adicione ao registro** em `cazenga_ui/utils/component_registry.py`
3. **Inclua documentação** no cabeçalho do arquivo HTML
4. **Adicione testes** se aplicável
5. **Atualize README** se necessário

#### Template para Componente

```html
{#
  Component: Nome do Componente
  Category: categoria
  Description: Descrição breve do componente
  
  Usage: {% include 'components/ui/nome.html' with ... %}
  
  Params:
    - param1: (type) Descrição do parâmetro
    - param2: (type) Descrição do parâmetro
  
  Variations: X
  Dependencies: component1, component2
  Requires JS: true/false
#}

<!-- Código HTML do componente -->
```

### Adicionando JavaScript

1. **Coloque arquivos JS** em `cazenga_ui/templates_source/js/`
2. **Use Alpine.js** para interatividade
3. **Documente funcionalidades** nos comentários
4. **Teste em diferentes navegadores**

### Executando Testes

```bash
# Todos os testes
pytest

# Testes específicos
pytest tests/test_ui_command.py

# Com coverage
pytest --cov=cazenga_ui

# Testes lentos (marcados como slow)
pytest -m "not slow"
```

### Documentação

- **README**: Para mudanças gerais na API
- **CHANGELOG**: Para todas as mudanças notáveis
- **Docstrings**: Para funções e classes
- **Comentários HTML**: Para componentes

## Padrões de Qualidade

### Code Review

- **Funcionalidade**: O código faz o que deveria fazer?
- **Legibilidade**: O código é fácil de entender?
- **Testes**: Há testes adequados?
- **Documentação**: Está bem documentado?
- **Performance**: Há problemas de performance?
- **Compatibilidade**: Funciona nas versões suportadas?

### Critérios de Aceitação

- [ ] Código segue padrões estabelecidos
- [ ] Testes passam
- [ ] Documentação atualizada
- [ ] Compatibilidade mantida
- [ ] Performance não degradada

## Processo de Release

1. **Atualizar versão** em `pyproject.toml`
2. **Atualizar CHANGELOG.md**
3. **Criar tag** seguindo semver: `git tag v1.2.3`
4. **Push da tag**: `git push origin v1.2.3`
5. **GitHub Actions** faz o release automaticamente

## Comunidade

- **Discord**: [Comunidade Cazenga](https://discord.gg/cazenga)
- **GitHub Discussions**: Para perguntas e discussões
- **Issues**: Para bugs e features

## Código de Conduta

Esperamos que todos os contribuidores sigam nosso código de conduta:

- **Seja respeitoso** com outros contribuidores
- **Seja paciente** com iniciantes
- **Seja construtivo** em críticas
- **Seja inclusivo** e acolhedor

## Agradecimentos

Obrigado por contribuir para o Django Cazenga UI! Sua ajuda torna este projeto melhor para toda a comunidade Django. 🙏

## Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a mesma licença MIT do projeto. 