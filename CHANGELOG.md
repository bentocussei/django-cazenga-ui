# Changelog

Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## [0.1.6] - 2025-01-09

### 🎯 Correção Definitiva
- **Problema identificado**: `tailwind init` faz DUAS perguntas, não apenas uma
  1. "Your Tailwind app/theme name (theme):"
  2. "Include daisyUI plugin? 1 - no, 2 - yes"
- **Solução**: Enviar ambas as respostas: `"theme\n1\n"` (nome + não incluir daisyUI)
- **Resultado**: Elimina erro "EOF when reading a line" completamente

### Debug Revelador
- Versão 0.1.5 permitiu capturar o STDOUT exato do comando
- Descobriu que o comando esperava duas entradas, não uma
- Evidência: `'  [1/2] Your Tailwind app/theme name... [2/2] Include daisyUI plugin?'`

## [0.1.5] - 2025-01-09

### Melhorias
- **Debug detalhado**: Adicionado logging completo para diagnosticar problemas com `tailwind init`
- **Fallback manual**: Se modo automático falhar, oferece instruções para execução manual
- **Timeout handling**: Implementado timeout de 30s para evitar travamentos
- **Verificação robusta**: Confirma se app theme foi criada antes de continuar

### Debug
- Mostra comando exato executado
- Exibe input enviado ao processo
- Captura stdout/stderr completos
- Traceback detalhado em caso de exceção

## [0.1.4] - 2025-01-09

### Correções
- **Comando tailwind init**: Revertido para implementação original que funciona corretamente
- **subprocess.Popen**: Usa `communicate()` com input via stdin (abordagem correta para django-tailwind)
- **Compatibilidade**: Funciona com todas as versões do django-tailwind que esperam input interativo
- **Lição**: A versão original já estava correta, problema era diferença entre código local vs PyPI

## [0.1.3] - 2025-01-09

### Correções (Revertidas)
- ~~Tentativa de compatibilidade com argumentos diretos~~ (não era necessário)
- ~~Fallback automático~~ (complicou desnecessariamente)

## [0.1.2] - 2025-01-09

### Melhorias
- **Instalação simplificada**: Dependências Tailwind (django-tailwind, django-browser-reload, django-mathfilters) agora são instaladas automaticamente com `pip install django-cazenga-ui`
- **Compatibilidade**: Mantido suporte a `pip install django-cazenga-ui[tailwind]` para compatibilidade com documentação existente
- **Documentação atualizada**: Simplificado comando de instalação em README, TUTORIAL e comandos CLI

### Correções
- **Comando tailwind init**: Corrigido erro "EOF when reading a line" ao executar `python manage.py cazenga init --with-tailwind`
- **Prevenção de erros**: Eliminado `ModuleNotFoundError` para django-tailwind, django-browser-reload e django-mathfilters
- **Experiência do usuário**: Instalação "funciona na primeira vez" sem necessidade de instalar dependências separadamente

## [0.1.1] - 2025-07-09 (Publicado)

### Melhorias  
- Dependências Tailwind movidas para principais

## [0.1.0] - 2025-07-08

### Adicionado

#### Componentes UI
- **52 componentes** HTML prontos para uso com Tailwind CSS e Alpine.js
- **Componentes básicos**: Button (9 variações), Card (3 variações), Badge (5 variações), Avatar (4 variações)
- **Componentes de formulário**: Input (7 variações), Textarea, Checkbox, Radio Group, Select, Switch, Form, Label
- **Componentes de navegação**: Sidebar (5 variações), Navigation Menu, Tabs, Breadcrumb, Pagination, Menubar
- **Componentes de feedback**: Alert (5 variações), Progress, Spinner (6 variações), Skeleton, Sonner (notifications)
- **Componentes de overlay**: Dialog, Alert Dialog, Drawer, Modal, Sheet, Popover, Tooltip
- **Componentes interativos**: Accordion, Carousel, Collapsible, Command, Context Menu, Dropdown, Toggle
- **Componentes de dados**: Table, Chart (4 tipos), Calendar
- **Componentes de layout**: Layout (4 estruturas), Separator, Aspect Ratio, Scroll Area, Resizable
- **Componentes especializados**: Input OTP (7 variações), Slider, Text Editor (6 tipos), Content Manager

#### Sistema de Ícones
- **333 ícones SVG** do Radix Icons incluídos
- Sistema de template tags para uso fácil de ícones
- Comando dedicado para instalação de ícones: `python manage.py ui icons`

#### Comandos CLI
- **`python manage.py ui list`**: Lista todos os componentes por categoria
- **`python manage.py ui info <componente>`**: Mostra detalhes de um componente específico
- **`python manage.py ui add <componente>`**: Instala componente com dependências e JS
- **`python manage.py ui icons`**: Gerencia instalação de ícones
- **`python manage.py cazenga init`**: Configuração inicial do projeto

#### Sistema de Registro
- Registro centralizado de componentes com metadados
- Gestão automática de dependências entre componentes
- Informações sobre variações, tags e arquivos JavaScript necessários

#### Funcionalidades
- **Instalação modular**: Instale apenas os componentes que precisa
- **Dependências automáticas**: Sistema detecta e instala dependências necessárias
- **Controle total**: Código copiado para seu projeto, você tem controle total
- **Temas customizáveis**: Sistema de variáveis CSS para personalização
- **Integração com django-tailwind**: Suporte nativo e configuração automática

#### JavaScript e Interatividade
- **5 arquivos JavaScript** para funcionalidades avançadas:
  - `spa.js`: Sistema SPA completo para navegação
  - `spa-intelligent.js`: SPA com funcionalidades inteligentes
  - `spa-simple.js`: SPA básico e leve
  - `spa-debug.js`: SPA com debug para desenvolvimento
  - `sidebar-highlight.js`: Destaque automático de links na sidebar

#### Configuração e Setup
- **Comando de inicialização**: Cria estrutura de diretórios e arquivos base
- **Template base.html** gerado automaticamente
- **Arquivo de tema CSS** com variáveis customizáveis
- **Configuração do Tailwind** com instruções detalhadas

#### Documentação
- README completo com exemplos de uso
- Documentação inline nos componentes
- Instruções de configuração do Tailwind CSS
- Guias de personalização e temas

#### Testes e Qualidade
- **Suite de testes** completa com pytest
- **Testes unitários** para comandos CLI
- **Testes de integração** para fluxos completos
- **CI/CD com GitHub Actions**:
  - Testes em múltiplas versões do Python (3.8-3.12)
  - Testes em múltiplas versões do Django (3.2-5.0)
  - Verificações de qualidade de código (black, isort, flake8)
  - Verificações de segurança (safety, bandit)
  - Publicação automática no PyPI

#### Empacotamento
- **Dependências incluídas**: `pip install django-cazenga-ui` (inclui dependências Tailwind)
- **Suporte a múltiplas versões**: Python 3.8+ e Django 3.2+
- **Metadados completos** no pyproject.toml
- **Manifesto de arquivos** para inclusão de templates e assets

### Características Técnicas
- **Arquitetura modular**: Cada componente é independente e pode ser usado isoladamente
- **Sistema de temas**: Variáveis CSS para customização completa
- **Acessibilidade**: Componentes seguem padrões ARIA e navegação por teclado
- **Performance**: Componentes otimizados com Tailwind CSS e Alpine.js
- **Responsividade**: Todos os componentes são mobile-first e responsivos

### Compatibilidade
- **Python**: 3.8, 3.9, 3.10, 3.11, 3.12
- **Django**: 3.2, 4.0, 4.1, 4.2, 5.0, 5.1
- **Tailwind CSS**: v3.0+ (v4.0+ recomendado)
- **Alpine.js**: v3.0+
- **Node.js**: 14+ (para Tailwind CSS)

## Tipos de Mudanças

- `Added` para novas funcionalidades
- `Changed` para mudanças em funcionalidades existentes
- `Deprecated` para funcionalidades que serão removidas em breve
- `Removed` para funcionalidades removidas
- `Fixed` para correções de bugs
- `Security` para correções de vulnerabilidades

## Versionamento

Este projeto usa [Versionamento Semântico](https://semver.org/lang/pt-BR/):

- **MAJOR** version quando você faz mudanças incompatíveis na API
- **MINOR** version quando você adiciona funcionalidades mantendo compatibilidade
- **PATCH** version quando você corrige bugs mantendo compatibilidade

[Não lançado]: https://github.com/cazenga/django-cazenga-ui/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/cazenga/django-cazenga-ui/releases/tag/v0.1.0 