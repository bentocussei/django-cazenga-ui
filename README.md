# Django Cazenga UI

Biblioteca moderna de componentes UI para Django usando Tailwind CSS v4 e Alpine.js, inspirada no shadcn/ui.

## 🚀 Quick Start

### 1. Instalação
```bash
pip install django-cazenga-ui
```

### 2. Auto-configuração (Recomendado)
```bash
cazenga-setup --auto-configure
```

### 3. Inicialização Interativa
```bash
python manage.py cazenga init --with-tailwind
```
**⚠️ IMPORTANTE**: O comando irá parar e pedir para você adicionar `'theme'` ao `INSTALLED_APPS` manualmente. Após adicionar, digite `1` para continuar.

### 4. Configuração Manual (Alternativa)
Se preferir configurar manualmente antes:

```python
# settings.py
INSTALLED_APPS += [
    'tailwind',
    'cazenga_ui',
    'django_browser_reload',
    'mathfilters',
    # 'theme',  # ← Será adicionado durante 'cazenga init'
]

MIDDLEWARE += [
    'django_browser_reload.middleware.BrowserReloadMiddleware',
]

TAILWIND_APP_NAME = 'theme'
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"  # Windows
# NPM_BIN_PATH = "/usr/local/bin/npm"  # macOS/Linux
```

### 5. Diagnóstico e Ajuda
```bash
cazenga-setup  # Status e orientações
python manage.py cazenga status  # Verificar configuração
```

## 📋 Fluxo Completo de Instalação

### Cenário A: Projeto Novo (Recomendado)
```bash
# 1. Instalar
pip install django-cazenga-ui

# 2. Auto-configurar dependências
cazenga-setup --auto-configure
# ✅ Configura automaticamente settings.py e urls.py

# 3. Inicializar (Processo Interativo)
python manage.py cazenga init --with-tailwind --theme default
# ⏸️ COMANDO IRÁ PARAR e mostrar:
# "📋 Você precisa adicionar a app 'theme' ao INSTALLED_APPS"
# 
# 4. Adicionar 'theme' ao settings.py:
# INSTALLED_APPS += ['theme']
# 
# 5. Digitar '1' para continuar
# ✅ Comando finaliza automaticamente

# 6. Executar projeto
python manage.py runserver
```

### Cenário B: Configuração Manual
```bash
# 1. Instalar
pip install django-cazenga-ui

# 2. Configurar settings.py manualmente (ver Quick Start)

# 3. Inicializar (mesmo processo interativo)
python manage.py cazenga init --with-tailwind

# 4. Quando parar, adicionar 'theme' ao INSTALLED_APPS
# 5. Digitar '1' para continuar
```

### Cenário C: Diagnóstico de Problemas
```bash
# Se receber "Unknown command: 'cazenga'"
cazenga-setup
# ✅ Mostra status e orientações detalhadas

# Seguir as orientações e depois:
python manage.py cazenga init --with-tailwind
```

## ⚠️ Troubleshooting

### "Unknown command: 'cazenga'"
- **Causa**: `cazenga_ui` não está no `INSTALLED_APPS`
- **Solução**: Adicionar `'cazenga_ui'` ao `INSTALLED_APPS` no settings.py

### "Unknown command: 'tailwind'"  
- **Causa**: `tailwind` não está no `INSTALLED_APPS`
- **Solução**: Adicionar `'tailwind'` ao `INSTALLED_APPS` no settings.py

### "TAILWIND_APP_NAME isn't set"
- **Causa**: Configuração incompleta
- **Solução**: Adicionar `TAILWIND_APP_NAME = 'theme'` ao settings.py

## 🎯 Arquitetura

```
projeto/
├── settings.py
│   ├── INSTALLED_APPS = ['tailwind', 'cazenga_ui', 'theme', ...]
│   └── TAILWIND_APP_NAME = 'theme'
├── cazenga_ui/          # ← Biblioteca (pip install)
└── theme/               # ← App Django local (django-tailwind)
    ├── static_src/      # ← Arquivos fonte CSS
    ├── static/          # ← CSS compilado
    └── templates/       # ← Templates base
```

- **cazenga_ui** = biblioteca com comandos e funcionalidades
- **theme** = app Django local com templates e assets estáticos

---

## 📦 Características

- **53 componentes** prontos para uso
- **6 temas de cores** (azul, laranja, verde, roxo, vermelho, amarelo)
- **333 ícones SVG** do Radix Icons
- **5 arquivos JavaScript** (incluindo sistema SPA completo)
- **Integração opcional** com django-tailwind
- **Comandos CLI** poderosos para gestão de componentes

## 📋 Pré-requisitos

- **Python 3.8+**
- **Django 3.2+**
- **Node.js 16+** (requerido para `--with-tailwind`)
- **npm** (incluído com Node.js)

### Instalação do Node.js

**Windows:**
```bash
# Baixe de: https://nodejs.org
# Ou use chocolatey:
choco install nodejs
```

**macOS:**
```bash
# Usando Homebrew:
brew install node
```

**Linux (Ubuntu/Debian):**
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Configuração do NPM (Windows)

Se encontrar problemas com npm no Windows, adicione ao `settings.py`:
```python
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"
```

## 🚀 Instalação

```bash
# Instalação (inclui dependências Tailwind)
pip install django-cazenga-ui

# Nota: também funciona com [tailwind] por compatibilidade
pip install django-cazenga-ui[tailwind]
```

## ⚙️ Configuração

### 1. Adicione ao INSTALLED_APPS

```python
# settings.py
INSTALLED_APPS = [
    # ... outras apps
    'cazenga_ui',
    'tailwind',  # se usando django-tailwind
    'theme',     # se usando django-tailwind
]
```

### 2. Inicialize o projeto

```bash
# Inicialização básica
python manage.py cazenga init

# Com django-tailwind (recomendado)
python manage.py cazenga init --with-tailwind

# Com tema específico
python manage.py cazenga init --theme roxo --with-tailwind
```

### 3. Compile os estilos

```bash
# Se usando django-tailwind
python manage.py tailwind build

# Para desenvolvimento
python manage.py tailwind start
```

## 🎨 Temas Disponíveis

A biblioteca oferece 6 temas de cores pré-configurados:

- **azul** - Tema clássico em tons de azul
- **laranja** - Tema energético em tons de laranja  
- **verde** - Tema natural em tons de verde
- **roxo** - Tema moderno em tons de roxo
- **vermelho** - Tema vibrante em tons de vermelho
- **amarelo** - Tema alegre em tons de amarelo

### Alternar Tema

```bash
# Listar temas disponíveis
python manage.py cazenga themes

# Alterar tema atual
python manage.py cazenga switch-theme verde
```

## 📂 Estrutura de Componentes

Os componentes estão organizados em duas pastas principais:

### UI Components (`components/ui/`)
Contém a maioria dos componentes de interface:
- **Básicos**: button, card, badge, avatar
- **Formulários**: input, textarea, checkbox, select, form
- **Navegação**: sidebar, tabs, breadcrumb, pagination
- **Feedback**: alert, progress, skeleton, spinner
- **Overlays**: dialog, modal, drawer, popover, tooltip
- **Interativos**: accordion, carousel, dropdown, toggle
- **Dados**: table, chart, calendar
- **Utilitários**: separator, aspect-ratio, scroll-area

### Layout Components (`components/layout/`)
Contém estruturas de layout de página:
- **layout** - Estruturas de página completas

## 🔧 Comandos CLI

### Comando Principal: `cazenga`

```bash
# Inicializar projeto
python manage.py cazenga init
python manage.py cazenga init --with-tailwind
python manage.py cazenga init --theme roxo

# Gerenciar temas
python manage.py cazenga themes
python manage.py cazenga switch-theme verde

# Verificar status
python manage.py cazenga status
```

### Comando de Componentes: `ui`

```bash
# Listar componentes
python manage.py ui list
python manage.py ui list --category form
python manage.py ui list --folder ui

# Informações de componente
python manage.py ui info button

# Adicionar componentes
python manage.py ui add button
python manage.py ui add form --with-dependencies

# Gerenciar ícones
python manage.py ui icons --install
python manage.py ui icons --count
```

## 💡 Uso Básico

### 1. Adicionar Componentes

```bash
# Instalar um botão
python manage.py ui add button

# Instalar formulário com dependências
python manage.py ui add form --with-dependencies
```

### 2. Usar nos Templates

```html
<!-- Template base -->
{% extends "base.html" %}
{% load icon_tags %}

{% block content %}
    <!-- Botão -->
    {% include "components/ui/button.html" %}
    
    <!-- Card -->
    {% include "components/ui/card.html" %}
    
    <!-- Layout completo -->
    {% include "components/layout/layout.html" %}
{% endblock %}
```

### 3. Ícones

```html
{% load icon_tags %}

<!-- Ícone básico -->
{% icon "check" %}

<!-- Com classes CSS -->
{% icon "check" class="w-4 h-4 text-green-500" %}

<!-- Com atributos -->
{% icon "star" class="w-6 h-6" title="Favorito" %}
```

## 🎯 Componentes por Categoria

### Básicos (4 componentes)
- **button** [9 variações] - Botão interativo
- **card** [3 variações] - Container de conteúdo  
- **badge** [5 variações] - Rótulos de status
- **avatar** [4 variações] - Imagens de perfil

### Formulários (8 componentes)
- **input** [7 variações] - Campos de texto
- **textarea** [4 variações] - Texto multilinha
- **checkbox** [4 variações] - Seleção múltipla
- **radio-group** [3 variações] - Seleção exclusiva
- **select** [6 variações] - Lista suspensa 🔧
- **switch** [3 variações] - Alternador on/off
- **form** [3 variações] - Container de formulário
- **label** [2 variações] - Rótulos de campos

### Navegação (6 componentes)
- **sidebar** [5 variações] - Painel lateral 🔧
- **tabs** [4 variações] - Navegação em abas 🔧
- **breadcrumb** [3 variações] - Trilha de navegação
- **pagination** [4 variações] - Navegação de páginas
- **navigation-menu** [5 variações] - Menu principal 🔧
- **menubar** [4 variações] - Barra de menu 🔧

### Feedback (5 componentes)
- **alert** [5 variações] - Mensagens de alerta
- **progress** [4 variações] - Indicador de progresso
- **skeleton** [5 variações] - Placeholder animado
- **spinner** [6 variações] - Indicador de carregamento
- **sonner** [8 variações] - Sistema de notificações 🔧

### Overlays (7 componentes)
- **dialog** [5 variações] - Janela modal 🔧
- **alert-dialog** [3 variações] - Dialog de confirmação 🔧
- **drawer** [3 variações] - Painel deslizante 🔧
- **modal** [5 variações] - Modal simples 🔧
- **sheet** [4 variações] - Painel inferior/lateral 🔧
- **popover** [5 variações] - Popup contextual 🔧
- **tooltip** [4 variações] - Dica ao passar mouse 🔧

### Interativos (10 componentes)
- **accordion** [4 variações] - Lista expansível 🔧
- **carousel** [3 variações] - Slider de imagens 🔧
- **collapsible** [3 variações] - Seção recolhível 🔧
- **command** [5 variações] - Paleta de comandos 🔧
- **context-menu** [3 variações] - Menu contextual 🔧
- **dropdown** [5 variações] - Menu suspenso 🔧
- **dropdown-menu** [4 variações] - Menu avançado 🔧
- **hover-card** [4 variações] - Card ao passar mouse 🔧
- **toggle** [4 variações] - Botão de alternância 🔧
- **toggle-group** [3 variações] - Grupo de toggles 🔧

### Dados (3 componentes)
- **table** [5 variações] - Tabela de dados 🔧
- **chart** [4 variações] - Gráficos e visualizações 🔧
- **calendar** [5 variações] - Seletor de data 🔧

### Layout (1 componente)
- **layout** [4 variações] - Estruturas de página

### Utilitários (5 componentes)
- **separator** [2 variações] - Linha divisória
- **aspect-ratio** [3 variações] - Container com proporção
- **scroll-area** [6 variações] - Área com scroll 🔧
- **resizable** [5 variações] - Painéis redimensionáveis 🔧
- **icon** [1 variação] - Sistema de ícones SVG

### Especializados (4 componentes)
- **input-otp** [7 variações] - Input para códigos OTP 🔧
- **slider** [6 variações] - Controle deslizante 🔧
- **text-editor** [6 variações] - Editor de texto rico 🔧
- **content-manager** [4 variações] - Sistema de CMS 🔧

🔧 = Requer JavaScript (Alpine.js)

## 🗂️ Arquivos JavaScript Incluídos

- **spa.js** - Sistema SPA completo (385 linhas)
- **spa-intelligent.js** - SPA com funcionalidades avançadas
- **spa-simple.js** - SPA básico e leve
- **spa-debug.js** - SPA com debug habilitado
- **sidebar-highlight.js** - Destaque automático de links do sidebar

## 📋 Status do Projeto

```bash
# Verificar configuração atual
python manage.py cazenga status
```

## 🤝 Filosofia

Django Cazenga UI **não é uma biblioteca tradicional**. Em vez de importar componentes como "caixa preta", ela **copia o código-fonte diretamente** para seu projeto, dando **controle total** sobre cada linha de código.

### Vantagens:
- ✅ **Controle total** sobre o código
- ✅ **Fácil personalização** de estilos e comportamento
- ✅ **Sem dependências ocultas** em runtime
- ✅ **Código transparente** e modificável
- ✅ **Aprendizado** através do código gerado

## 📚 Exemplos de Uso

### Template Base Completo

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Django Cazenga UI{% endblock %}</title>
    
    {% load tailwind_tags %}
    {% tailwind_css %}
    
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    {% load icon_tags %}
</head>
<body class="bg-background text-foreground">
    <div id="app">
        {% block content %}{% endblock %}
    </div>
</body>
</html>
```

### Página com Componentes

```html
{% extends "base.html" %}

{% block content %}
<div class="container mx-auto p-6">
    <!-- Card com conteúdo -->
    <div class="card max-w-md mx-auto">
        <div class="card-header">
            <h2 class="card-title">Bem-vindo</h2>
            <p class="card-description">Sistema Django Cazenga UI</p>
        </div>
        <div class="card-content">
            <!-- Formulário -->
            {% include "components/ui/form.html" %}
        </div>
        <div class="card-footer">
            <!-- Botões -->
            {% include "components/ui/button.html" %}
        </div>
    </div>
    
    <!-- Alertas -->
    {% include "components/ui/alert.html" %}
    
    <!-- Ícones -->
    <div class="flex gap-4 mt-6">
        {% icon "check" class="w-6 h-6 text-green-500" %}
        {% icon "star" class="w-6 h-6 text-yellow-500" %}
        {% icon "heart" class="w-6 h-6 text-red-500" %}
    </div>
</div>
{% endblock %}
```

## 🔄 Atualizações

Para manter a biblioteca atualizada:

```bash
pip install --upgrade django-cazenga-ui
```

## 📖 Documentação Adicional

- [Guia de Contribuição](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)
- [Testes](tests/)

## 📄 Licença

MIT License - veja [LICENSE](LICENSE) para detalhes.

---

**Django Cazenga UI** - Desenvolvimento rápido, controle total. 🚀