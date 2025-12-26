#!/bin/bash

# =====================================================
# MELLØ Protocol - Environment Setup
# =====================================================
# Instala e sincroniza todas as configurações
# Author: MELLØ // POST-HUMAN
# =====================================================

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Diretórios
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.config/neo_mello/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# =====================================================
# FUNÇÕES
# =====================================================

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  MELLØ Protocol - Environment Setup${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${YELLOW}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Função para verificar se arquivo/diretório existe antes de copiar
check_and_copy() {
    local source="$1"
    local dest="$2"
    local description="$3"
    
    if [ -f "$source" ] || [ -d "$source" ]; then
        if [ -f "$dest" ] || [ -d "$dest" ]; then
            # Fazer backup antes de sobrescrever
            mkdir -p "$BACKUP_DIR"
            cp -r "$dest" "$BACKUP_DIR/$(basename "$dest").$TIMESTAMP" 2>/dev/null || true
        fi
        cp -r "$source" "$dest" 2>/dev/null
        print_success "$description"
        return 0
    else
        print_warning "$description não encontrado (pulando: $source)"
        return 1
    fi
}

create_backup() {
    local file="$1"
    local name=$(basename "$file")
    
    if [ -f "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/${name}.${TIMESTAMP}.backup"
        print_success "Backup criado: ${name}"
    fi
}

# =====================================================
# 1. PRÉ-INSTALAÇÃO
# =====================================================

print_header

print_section "1. Verificando requisitos"

# Verificar Homebrew
if ! command -v brew &> /dev/null; then
    print_error "Homebrew não instalado"
    echo "Instale com: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi
print_success "Homebrew encontrado"

# Verificar Git
if ! command -v git &> /dev/null; then
    print_error "Git não instalado"
    exit 1
fi
print_success "Git encontrado"

# =====================================================
# 2. BACKUP
# =====================================================

print_section "2. Criando backups"

create_backup "$HOME/.zshrc"
create_backup "$HOME/Library/Application Support/Code/User/settings.json"
create_backup "$HOME/Library/Application Support/Cursor/User/settings.json"

# =====================================================
# 3. TERMINAL
# =====================================================

print_section "3. Configurando terminal"

# .zshrc.secrets (verificar se existe, se não, avisar)
if [ ! -f "$HOME/.zshrc.secrets" ]; then
    print_warning ".zshrc.secrets não encontrado"
    print_warning "Crie manualmente: cursor ~/.zshrc.secrets"
    print_warning "Consulte: standards/zshrc.rules.md para estrutura"
else
    print_success ".zshrc.secrets já existe (preservado)"
fi

# =====================================================
# 4. EDITORES
# =====================================================

print_section "4. Configurando editores"

# VS Code
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_DIR" ]; then
    if [ -f "$REPO_DIR/infra/editors/settings.json" ]; then
        cp "$REPO_DIR/infra/editors/settings.json" "$VSCODE_DIR/settings.json"
        print_success "VS Code settings instalado"
    elif [ -f "$REPO_DIR/editors/settings.json" ]; then
        cp "$REPO_DIR/editors/settings.json" "$VSCODE_DIR/settings.json"
        print_success "VS Code settings instalado"
    fi
    
    if [ -f "$REPO_DIR/infra/editors/keybindings.json" ]; then
        cp "$REPO_DIR/infra/editors/keybindings.json" "$VSCODE_DIR/keybindings.json"
        print_success "VS Code keybindings instalado"
    elif [ -f "$REPO_DIR/editors/keybindings.json" ]; then
        cp "$REPO_DIR/editors/keybindings.json" "$VSCODE_DIR/keybindings.json"
        print_success "VS Code keybindings instalado"
    fi
else
    print_warning "VS Code não encontrado"
fi

# Cursor
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
if [ -d "$CURSOR_DIR" ]; then
    # Verificar múltiplos locais possíveis para settings.json
    if [ -f "$REPO_DIR/infra/editors/settings.json" ]; then
        check_and_copy "$REPO_DIR/infra/editors/settings.json" "$CURSOR_DIR/settings.json" "Cursor settings instalado"
    elif [ -f "$REPO_DIR/editors/settings.json" ]; then
        check_and_copy "$REPO_DIR/editors/settings.json" "$CURSOR_DIR/settings.json" "Cursor settings instalado"
    fi
    
    # MCP Servers
    if [ -f "$REPO_DIR/mcp-servers.json.template" ]; then
        cp "$REPO_DIR/mcp-servers.json.template" "$CURSOR_DIR/mcp-servers.json"
        
        # Substituir placeholder da thirdweb secret key se existir
        if [ -f "$HOME/.zshrc.secrets" ]; then
            THIRDWEB_KEY=$(grep "^export THIRDWEB_SECRET_KEY=" "$HOME/.zshrc.secrets" | cut -d'"' -f2)
            if [ -n "$THIRDWEB_KEY" ]; then
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i '' "s|YOUR_THIRDWEB_SECRET_KEY|$THIRDWEB_KEY|g" "$CURSOR_DIR/mcp-servers.json"
                else
                    sed -i "s|YOUR_THIRDWEB_SECRET_KEY|$THIRDWEB_KEY|g" "$CURSOR_DIR/mcp-servers.json"
                fi
                print_success "MCP Servers configurado (thirdweb key inserida)"
            else
                print_warning "MCP Servers configurado (substitua YOUR_THIRDWEB_SECRET_KEY manualmente)"
            fi
        else
            print_warning "MCP Servers configurado (substitua YOUR_THIRDWEB_SECRET_KEY manualmente)"
        fi
    elif [ -f "$REPO_DIR/infra/editors/mcp-servers.json" ]; then
        cp "$REPO_DIR/infra/editors/mcp-servers.json" "$CURSOR_DIR/mcp-servers.json"
        print_success "MCP Servers configurado"
    elif [ -f "$REPO_DIR/editors/mcp-servers.json" ]; then
        cp "$REPO_DIR/editors/mcp-servers.json" "$CURSOR_DIR/mcp-servers.json"
        print_success "MCP Servers configurado"
    fi
else
    print_warning "Cursor não encontrado"
fi


# =====================================================
# 5. GIT
# =====================================================

print_section "5. Configurando Git"

# Verificar gitconfig (pode não existir no repositório)
if [ -f "$REPO_DIR/mello-env/git/.gitconfig" ]; then
    GITCONFIG_SOURCE="$REPO_DIR/mello-env/git/.gitconfig"
elif [ -f "$REPO_DIR/git/.gitconfig" ]; then
    GITCONFIG_SOURCE="$REPO_DIR/git/.gitconfig"
else
    GITCONFIG_SOURCE=""
fi

if [ -n "$GITCONFIG_SOURCE" ]; then
    # Fazer merge com gitconfig existente (apenas se não existir)
    if [ -f "$HOME/.gitconfig" ]; then
        # Verificar se já foi adicionado (evitar duplicação)
        if ! grep -q "# MELLØ Protocol" "$HOME/.gitconfig" 2>/dev/null; then
            print_warning "Fazendo merge com .gitconfig existente"
            echo "" >> "$HOME/.gitconfig"
            echo "# MELLØ Protocol" >> "$HOME/.gitconfig"
            cat "$GITCONFIG_SOURCE" >> "$HOME/.gitconfig"
        else
            print_warning ".gitconfig já contém configurações MELLØ (preservado)"
        fi
    else
        cp "$GITCONFIG_SOURCE" "$HOME/.gitconfig"
    fi
    print_success "Git config instalado"
else
    print_warning "Git config não encontrado no repositório (pulando)"
fi

# Verificar gitignore global
if [ -f "$REPO_DIR/mello-env/git/.gitignore_global" ]; then
    GITIGNORE_SOURCE="$REPO_DIR/mello-env/git/.gitignore_global"
elif [ -f "$REPO_DIR/git/.gitignore_global" ]; then
    GITIGNORE_SOURCE="$REPO_DIR/git/.gitignore_global"
else
    GITIGNORE_SOURCE=""
fi

if [ -n "$GITIGNORE_SOURCE" ]; then
    cp "$GITIGNORE_SOURCE" "$HOME/.gitignore_global"
    git config --global core.excludesfile "$HOME/.gitignore_global"
    print_success "Gitignore global instalado"
fi

# =====================================================
# 6. EXTENSÕES
# =====================================================

print_section "6. Verificando extensões"

if [ -f "$REPO_DIR/standards/extensions.txt" ]; then
    echo "Extensões listadas em: standards/extensions.txt"
    echo "Para instalar: cat standards/extensions.txt | grep -v '^#' | grep -v '^$' | xargs -L 1 cursor --install-extension"
    print_warning "Execute manualmente se necessário"
elif [ -f "$REPO_DIR/editors/extensions.txt" ]; then
    echo "Extensões listadas em: editors/extensions.txt"
    echo "Para instalar: cat editors/extensions.txt | xargs -L 1 code --install-extension"
    print_warning "Execute manualmente se necessário"
fi

# =====================================================
# 7. PÓS-INSTALAÇÃO
# =====================================================

print_section "7. Finalizando"

# Criar estrutura de diretórios
mkdir -p "$HOME/bin"
mkdir -p "$HOME/CODIGOS/neo-dev/projects"

# Adicionar scripts ao PATH
if [ -d "$REPO_DIR/scripts" ]; then
    if ls "$REPO_DIR/scripts"/*.sh 1> /dev/null 2>&1; then
        chmod +x "$REPO_DIR/scripts"/*.sh
        print_success "Scripts executáveis"
    fi
fi

# =====================================================
# RESUMO
# =====================================================

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Instalação concluída!${NC}"
echo ""
echo -e "${YELLOW}Próximos passos:${NC}"
echo ""
echo "1. Configure suas API keys:"
if command -v cursor &> /dev/null; then
    echo "   ${BLUE}cursor ~/.zshrc.secrets${NC}"
elif command -v code &> /dev/null; then
    echo "   ${BLUE}code ~/.zshrc.secrets${NC}"
else
    echo "   ${BLUE}${EDITOR:-nano} ~/.zshrc.secrets${NC}"
fi
echo ""
echo "2. Recarregue o shell:"
echo "   ${BLUE}source ~/.zshrc${NC}"
echo ""
echo "3. Instale extensões (opcional):"
echo "   ${BLUE}cat standards/extensions.txt | grep -v '^#' | grep -v '^$' | xargs -L 1 cursor --install-extension${NC}"
echo ""
echo "4. Verifique backups em:"
echo "   ${BLUE}$BACKUP_DIR${NC}"
echo ""
echo -e "${YELLOW}⚠️ Lembre-se: NUNCA versione ~/.zshrc.secrets no Git!${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""