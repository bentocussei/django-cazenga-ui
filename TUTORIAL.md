# Tutorial Completo - Django Cazenga UI

## 📚 Índice

1. [Pré-requisitos](#pré-requisitos)
2. [Visão Geral](#visão-geral)
3. [Instalação](#instalação)
4. [Comandos Disponíveis](#comandos-disponíveis)
5. [Estrutura de Arquivos](#estrutura-de-arquivos)
6. [Exemplos Práticos](#exemplos-práticos)
7. [Solução de Problemas](#solução-de-problemas)

## 📋 Pré-requisitos

### Software Necessário

- **Python 3.8+**
- **Django 3.2+**
- **Node.js 16+** (obrigatório para `--with-tailwind`)
- **npm** (incluído com Node.js)

### Instalação dos Pré-requisitos

#### 1. Node.js e npm

**Windows:**
```bash
# Opção 1: Baixar instalador oficial
# Acesse: https://nodejs.org e baixe a versão LTS

# Opção 2: Usar chocolatey
choco install nodejs

# Opção 3: Usar scoop
scoop install nodejs
```

**macOS:**
```bash
# Opção 1: Usar Homebrew
brew install node

# Opção 2: Baixar instalador oficial
# Acesse: https://nodejs.org
```

**Linux (Ubuntu/Debian):**
```bash
# Instalar Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar instalação
node --version
npm --version
```

**Linux (CentOS/RHEL):**
```bash
# Instalar Node.js 18.x
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Verificar instalação
node --version
npm --version
```

#### 2. Verificar Instalação

```bash
# Verificar se tudo está instalado
node --version  # Deve mostrar v16.x.x ou superior
npm --version   # Deve mostrar versão do npm
python --version  # Deve mostrar 3.8.x ou superior
```

### Problemas Comuns de Instalação

**Windows - Erro de Permissão npm:**
```bash
# Configurar diretório global do npm
npm config set prefix %APPDATA%\npm

# Ou usar NPM_BIN_PATH no settings.py
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"
```

**macOS - Erro de Permissão:**
```bash
# Reconfigurar npm para usar diretório do usuário
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile
```

**Linux - Erro de Permissão:**
```bash
# Configurar npm para usar diretório do usuário
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

## 🎯 Visão Geral

**Django Cazenga UI** é uma biblioteca que **copia código-fonte** diretamente para seu projeto, dando controle total sobre cada componente. Não é uma biblioteca tradicional que você importa - é um sistema que gera código personalizável.

### Como Funciona

1. **Instala**: `pip install django-cazenga-ui`
2. **Inicializa**: `python manage.py cazenga init --with-tailwind`
3. **Adiciona componentes**: `python manage.py ui add button`
4. **Personaliza**: Edita os arquivos HTML/CSS copiados

## ⚡ Processo Interativo Explicado

O Django Cazenga UI utiliza um **processo interativo** para evitar problemas de dependência circular entre Django e django-tailwind.

### 🤔 Por que é necessário?

1. **Problema**: A app `theme` só pode estar no `INSTALLED_APPS` **depois** de ser criada
2. **Solução**: O comando `cazenga init --with-tailwind` para e pede para você adicionar manualmente
3. **Vantagem**: Evita erros e dá controle total sobre a configuração

### 📋 Como funciona o processo:

```bash
# 1. Comando inicia normalmente
python manage.py cazenga init --with-tailwind

# 2. Executa tarefas iniciais:
🔧 Configurando django-tailwind...
🎨 Configurando tema...
📁 Criando estrutura...

# 3. Para e mostra instruções:
⏸️  AÇÃO NECESSÁRIA:
📋 Você precisa adicionar a app "theme" ao INSTALLED_APPS em settings.py
📁 Arquivo: /caminho/para/settings.py
🔧 Adicione esta linha ao INSTALLED_APPS: 'theme',

# 4. Você adiciona manualmente:
INSTALLED_APPS += ['theme']

# 5. Digita '1' para continuar:
🔄 Após adicionar "theme" ao INSTALLED_APPS, digite 1 para continuar: 1

# 6. Comando finaliza automaticamente:
✅ tailwind install executado com sucesso
✅ tailwind build executado com sucesso
```

### 🎯 Vantagens deste processo:

- ✅ **Sem erros de dependência circular**
- ✅ **Controle total** sobre o que é adicionado ao projeto
- ✅ **Transparência** - você vê exatamente o que está acontecendo
- ✅ **Flexibilidade** - pode cancelar a qualquer momento

## 🚀 Instalação

### Opção 1: Instalação Automática (Recomendada)

```bash
# 1. Instalar biblioteca com todas as dependências
pip install django-cazenga-ui

# 2. Auto-configurar projeto (configura settings.py e urls.py)
cazenga-setup --auto-configure
# ✅ Adiciona automaticamente dependências básicas ao INSTALLED_APPS

# 3. Inicializar projeto (Processo Interativo)
python manage.py cazenga init --with-tailwind --theme roxo

# ⚠️ IMPORTANTE: O comando irá PARAR em um ponto e mostrar:
# "📋 Você precisa adicionar a app 'theme' ao INSTALLED_APPS em settings.py"
# 
# 4. Abrir settings.py e adicionar:
# INSTALLED_APPS += ['theme']
# 
# 5. Salvar arquivo e digitar '1' no terminal para continuar
# ✅ O comando finaliza automaticamente (instala npm + compila CSS)
```

**⚠️ Por que esse processo?**
A app `theme` só pode ser adicionada ao `INSTALLED_APPS` **depois** de ser criada pelo django-tailwind. Isso evita erros de dependência circular.

### Opção 2: Instalação Separada

```bash
# 1. Primeiro instalar django-tailwind separadamente
pip install django-tailwind[reload]

# 2. Configurar django-tailwind
python manage.py tailwind init cazenga_ui  # ← Nome da app: cazenga_ui

# 3. Configurar settings.py (mesmo que acima)

# 4. Instalar e testar tailwind
python manage.py tailwind install
python manage.py tailwind start  # Em terminal separado

# 5. Instalar Django Cazenga UI
pip install django-cazenga-ui

# 6. Inicializar sem --with-tailwind
python manage.py cazenga init --theme verde
```

## 🔧 Comandos Disponíveis

### Comando Principal: `cazenga`

#### `cazenga init`
Inicializa o projeto e cria estrutura básica.

```bash
# Básico
python manage.py cazenga init

# Com django-tailwind automático
python manage.py cazenga init --with-tailwind

# Com tema específico
python manage.py cazenga init --theme roxo --with-tailwind

# Pular instalação npm
python manage.py cazenga init --with-tailwind --skip-npm
```

**O que faz:**
- Verifica se Node.js está instalado (se `--with-tailwind`)
- Cria estrutura de diretórios
- Instala tema de cores escolhido
- Copia `components.css`
- Gera `base.html` configurado
- Configura django-tailwind (se `--with-tailwind`)

#### `cazenga themes`
Lista todos os temas disponíveis.

```bash
python manage.py cazenga themes
```

**Saída:**
```
🎨 Temas disponíveis:
  azul       - Tema clássico em tons de azul
  laranja    - Tema energético em tons de laranja
  verde      - Tema natural em tons de verde
  roxo       - Tema moderno em tons de roxo
  vermelho   - Tema vibrante em tons de vermelho
  amarelo    - Tema alegre em tons de amarelo
```

#### `cazenga switch-theme`
Altera o tema atual do projeto.

```bash
python manage.py cazenga switch-theme verde
```

**O que faz:**
- Substitui arquivo de tema atual
- Mantém componentes existentes
- Requer recompilação do CSS

#### `cazenga status`
Mostra status da configuração atual.

```bash
python manage.py cazenga status
```

**Verifica:**
- Estrutura de diretórios
- Instalação do django-tailwind
- Tema atual
- Configurações necessárias

### Comando de Componentes: `ui`

#### `ui list`
Lista componentes disponíveis.

```bash
# Todos os componentes
python manage.py ui list

# Por categoria
python manage.py ui list --category form

# Por pasta (ui ou layout)
python manage.py ui list --folder ui
python manage.py ui list --folder layout
```

**Saída de exemplo:**
```
📦 Todos os componentes disponíveis:

  BASIC:
    🎨 button [9x] - Botão interativo com múltiplas variantes
    🎨 card [3x] - Container de conteúdo com header, body

  FORM:
    🎨 input [7x] - Campo de entrada de texto
    🎨 form [3x] 🔧 - Container de formulário (depende de: input, button)

Total: 53 componentes
```

**Legenda:**
- 🎨 = Componente UI
- 📐 = Componente Layout
- 🔧 = Requer JavaScript
- [9x] = Número de variações
- (depende de: ...) = Dependências

#### `ui info`
Mostra informações detalhadas de um componente.

```bash
python manage.py ui info button
```

**Saída:**
```
📋 Informações do componente "button":
  Descrição: Botão interativo com múltiplas variantes e tamanhos
  Categoria: basic
  Pasta: ui/
  Variações: 9
  Dependências: Nenhuma
  JavaScript: Não necessário
  Tags: form, interactive, action
```

#### `ui add`
Adiciona componente(s) ao projeto.

```bash
# Componente simples
python manage.py ui add button

# Com dependências automáticas
python manage.py ui add form --with-dependencies

# Forçar sobrescrever
python manage.py ui add card --force
```

**O que faz:**
- Copia arquivo HTML para pasta correta
- Instala dependências (se `--with-dependencies`)
- Copia arquivos JavaScript necessários
- Mostra instruções de uso

#### `ui icons`
Gerencia ícones SVG.

```bash
# Contar ícones disponíveis
python manage.py ui icons --count

# Instalar todos os ícones
python manage.py ui icons --install
```

**Saída:**
```
📊 Ícones disponíveis: 333
   Exemplos: check, star, heart, home, user
   ... e mais 328 ícones

✅ 333 ícones instalados em static/icons/
```

## 📂 Estrutura de Arquivos

### Estrutura Final (Após Configuração)

```
meu-projeto/
├── cazenga_ui/                    # App criada pelo django-tailwind
│   ├── static_src/
│   │   ├── package.json          # Gerenciado pelo django-tailwind
│   │   ├── postcss.config.js     # Configuração PostCSS
│   │   └── src/
│   │       ├── styles.css        # Tema + Tailwind CSS
│   │       └── components.css    # Classes de componentes
│   ├── static/
│   │   ├── css/dist/styles.css   # CSS compilado
│   │   ├── js/                   # Arquivos JavaScript copiados
│   │   └── icons/                # Ícones SVG (333 arquivos)
│   └── templates/
│       ├── base.html             # Template base configurado
│       └── components/
│           ├── ui/               # Componentes de interface
│           │   ├── button.html
│           │   ├── card.html
│           │   ├── form.html
│           │   └── ...
│           └── layout/           # Componentes de layout
│               └── layout.html
├── minha_app/                    # Suas apps Django
├── manage.py
└── requirements.txt
```

### Fluxo de Arquivos

1. **Temas**: `cazenga_ui/static_src/src/styles.css`
2. **Componentes CSS**: `cazenga_ui/static_src/src/components.css`
3. **Compilação**: `cazenga_ui/static/css/dist/styles.css`
4. **Templates**: `cazenga_ui/templates/components/ui/`
5. **JavaScript**: `cazenga_ui/static/js/`
6. **Ícones**: `cazenga_ui/static/icons/`

## 💡 Exemplos Práticos

### Exemplo 1: Projeto Simples

```bash
# 1. Criar projeto
django-admin startproject meu_blog
cd meu_blog

# 2. Instalar
pip install django-cazenga-ui

# 3. Auto-configurar
cazenga-setup --auto-configure
# ✅ Configura automaticamente settings.py

# 4. Inicializar (Processo Interativo)
python manage.py cazenga init --with-tailwind --theme azul

# ⏸️ COMANDO PARA AQUI - Você verá:
# "📋 Você precisa adicionar a app 'theme' ao INSTALLED_APPS"

# 5. Abrir settings.py e adicionar:
# INSTALLED_APPS += ['theme']

# 6. Digitar '1' no terminal para continuar
# ✅ Comando finaliza automaticamente

# 7. Adicionar componentes
python manage.py ui add card
python manage.py ui add button
python manage.py ui icons --install

# 8. Testar
python manage.py runserver
```

### Exemplo 2: Uso em Templates

```html
<!-- minha_app/templates/home.html -->
{% extends "cazenga_ui/templates/base.html" %}
{% load icon_tags %}

{% block content %}
<div class="container mx-auto p-6">
    <!-- Card principal -->
    <div class="card max-w-lg mx-auto">
        <div class="card-header">
            <h1 class="card-title">
                {% icon "star" class="w-6 h-6 inline" %}
                Meu Blog
            </h1>
            <p class="card-description">Bem-vindo ao sistema</p>
        </div>
        
        <div class="card-content">
            <p>Conteúdo do card aqui...</p>
            
            <!-- Incluir componente button -->
            {% include "components/ui/button.html" with text="Ler Mais" variant="primary" %}
        </div>
    </div>
    
    <!-- Alerta -->
    {% include "components/ui/alert.html" with message="Sistema funcionando!" type="success" %}
</div>
{% endblock %}
```

### Exemplo 3: Personalização de Componente

```html
<!-- cazenga_ui/templates/components/ui/button.html -->
<!-- Você pode editar este arquivo diretamente! -->

<button 
    class="btn {{ variant|default:'btn-primary' }} {{ size|default:'btn-md' }} {{ class|default:'' }}"
    {% if onclick %}onclick="{{ onclick }}"{% endif %}
    {% if disabled %}disabled{% endif %}
>
    {% if icon %}
        {% icon icon class="w-4 h-4 mr-2" %}
    {% endif %}
    {{ text|default:"Botão" }}
</button>

<!-- Variações disponíveis: -->
<!-- variant: primary, secondary, destructive, outline, ghost, link -->
<!-- size: sm, md, lg -->
```

### Exemplo 4: Tema Personalizado

```css
/* cazenga_ui/static_src/src/styles.css */
/* Você pode personalizar as cores do tema: */

:root {
    /* Personalizar primary para sua marca */
    --primary: oklch(0.5 0.2 240);  /* Azul personalizado */
    --primary-foreground: oklch(1 0 0);
    
    /* Adicionar suas próprias variáveis */
    --minha-cor: oklch(0.7 0.15 120);
}

/* Suas classes personalizadas */
.meu-botao-especial {
    background-color: var(--minha-cor);
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
}
```

## 🛠️ Solução de Problemas

### Problema: Node.js não encontrado

```bash
# Erro durante cazenga init --with-tailwind
❌ Node.js não está instalado ou não foi encontrado.

# Soluções:
1. Instalar Node.js: https://nodejs.org
2. Verificar instalação: node --version
3. Usar --skip-npm: python manage.py cazenga init --with-tailwind --skip-npm
4. Configurar caminho manual (Windows):
   NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"
```

### Problema: "Componente não encontrado"

```bash
# Erro
❌ Componente "button" não encontrado

# Solução
python manage.py ui list  # Verificar nomes corretos
python manage.py ui add button  # Nome exato
```

### Problema: "Projeto não configurado"

```bash
# Erro
❌ Projeto não está configurado. Execute "python manage.py cazenga init" primeiro.

# Solução
python manage.py cazenga init --with-tailwind
# ⚠️ Lembre-se: o comando irá parar para você adicionar 'theme' ao INSTALLED_APPS
```

### Problema: Comando "para" durante a execução

```bash
# Situação normal:
⏸️  AÇÃO NECESSÁRIA:
📋 Você precisa adicionar a app "theme" ao INSTALLED_APPS

# Isso é esperado! Não é um erro.
# Solução:
1. Abrir settings.py
2. Adicionar 'theme' ao INSTALLED_APPS
3. Salvar arquivo
4. Digitar '1' no terminal
5. Comando continua automaticamente
```

### Problema: CSS não está funcionando

```bash
# Verificar status
python manage.py cazenga status

# Recompilar CSS
python manage.py tailwind build

# Para desenvolvimento
python manage.py tailwind start
```

### Problema: Ícones não aparecem

```bash
# Instalar ícones
python manage.py ui icons --install

# Verificar template tags
{% load icon_tags %}
{% icon "check" %}

# Verificar se cazenga_ui está em INSTALLED_APPS
```

### Problema: django-tailwind não funciona

```bash
# Verificar instalação do Node.js
node --version
npm --version

# Configurar caminho do npm (Windows)
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"

# Reinstalar dependências
python manage.py tailwind install
```

### Problema: Erro de permissão npm (Windows)

```bash
# Configurar npm para usar diretório do usuário
npm config set prefix %APPDATA%\npm

# Ou configurar no settings.py
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"

# Ou executar como administrador
```

### Problema: Erro de permissão npm (macOS/Linux)

```bash
# Configurar npm para usar diretório do usuário
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile
```

### Problema: Alterações CSS não aparecem

```bash
# Modo desenvolvimento (hot reload)
python manage.py tailwind start

# Build para produção
python manage.py tailwind build

# Verificar se middleware está ativo
MIDDLEWARE = [
    'django_browser_reload.middleware.BrowserReloadMiddleware',
    # ...
]
```

### Problema: Comando npm não encontrado

```bash
# Windows
# Verificar se Node.js está no PATH
echo %PATH%

# Adicionar ao PATH ou usar caminho completo
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"

# macOS/Linux
# Verificar se npm está no PATH
echo $PATH

# Recarregar shell
source ~/.bashrc  # ou ~/.zshrc
```

## 📚 Referência Rápida

### Comandos Essenciais

```bash
# Configuração inicial
cazenga-setup --auto-configure                      # Auto-configurar dependências
python manage.py cazenga init --with-tailwind --theme roxo
# ⏸️ Adicionar 'theme' ao INSTALLED_APPS quando solicitado

# Desenvolvimento diário
python manage.py tailwind start         # Terminal 1
python manage.py runserver             # Terminal 2

# Gerenciar componentes
python manage.py ui list
python manage.py ui add button
python manage.py ui add form --with-dependencies

# Gerenciar temas
python manage.py cazenga themes
python manage.py cazenga switch-theme verde

# Ícones
python manage.py ui icons --install

# Diagnóstico
cazenga-setup                                        # Status e orientações
python manage.py cazenga status                     # Verificar configuração
```

## 🔧 Configuração Avançada

### settings.py Completo

```python
# settings.py
import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

# Apps
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # Django Cazenga UI
    'cazenga_ui',
    'tailwind',
    'django_browser_reload',
    'mathfilters',
    
    # Suas apps
    'minha_app',
]

# Middleware
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    
    # Hot reload
    'django_browser_reload.middleware.BrowserReloadMiddleware',
]

# Tailwind
TAILWIND_APP_NAME = 'cazenga_ui'

# NPM (Windows - opcional)
NPM_BIN_PATH = r"C:\Program Files\nodejs\npm.cmd"

# Configuração interna do IP (para hot reload)
INTERNAL_IPS = [
    '127.0.0.1',
]

# Templates
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            BASE_DIR / 'templates',
            BASE_DIR / 'cazenga_ui' / 'templates',
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# Estaticos
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    BASE_DIR / 'static',
    BASE_DIR / 'cazenga_ui' / 'static',
]
STATIC_ROOT = BASE_DIR / 'staticfiles'
```

### Fluxo de Desenvolvimento

```bash
# 1. Configuração inicial (uma vez)
pip install django-cazenga-ui[tailwind]
cazenga-setup --auto-configure                     # Auto-configurar dependências
python manage.py cazenga init --with-tailwind --theme roxo
# ⏸️ Parar para adicionar 'theme' ao INSTALLED_APPS e digitar '1'

# 2. Desenvolvimento diário
python manage.py tailwind start    # Terminal 1 - Hot reload CSS
python manage.py runserver         # Terminal 2 - Servidor Django

# 3. Adicionar componentes conforme necessário
python manage.py ui add button
python manage.py ui add form --with-dependencies
python manage.py ui icons --install

# 4. Build para produção
python manage.py tailwind build
python manage.py collectstatic
```

### Dicas de Performance

```bash
# Compilar CSS apenas quando necessário
python manage.py tailwind build

# Usar hot reload apenas em desenvolvimento
python manage.py tailwind start

# Verificar tamanho do CSS compilado
ls -la cazenga_ui/static/css/dist/styles.css

# Otimizar para produção
python manage.py tailwind build --minify
```

## 🎯 Próximos Passos

1. **Explore os componentes**: `python manage.py ui list`
2. **Teste diferentes temas**: `python manage.py cazenga switch-theme verde`
3. **Personalize estilos**: Edite `cazenga_ui/static_src/src/styles.css`
4. **Modifique componentes**: Edite arquivos em `cazenga_ui/templates/components/`
5. **Adicione seus próprios**: Crie novos componentes baseados nos existentes

**Lembre-se**: Você tem controle total sobre todo o código gerado! 🚀 