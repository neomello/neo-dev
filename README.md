<!-- diário técnico vivo -->

# NEØ — Dev Log

Agora estou:

-  reorganizando minha cabeça como dev solo
-  evitando abrir novos projetos
-  focando em um fluxo sustentável

Hoje:

-  [ ] revisar código X
-  [ ] documentar ideia Y


## NEØ Dev Workspace

Workspace padronizado para desenvolvimento seguindo o **NEØ Protocol**. Este repositório serve como template e backup completo do ambiente de trabalho, garantindo recuperação total mesmo após perda de dados.

## Propósito

Este workspace centraliza:

-  **Padrões de código** (`standards/`) - Regras e convenções
-  **Scripts de automação** (`scripts/`) - Instalação e sincronização
-  **Projetos** (`projects/`) - Trabalhos em andamento
-  **Backup completo** - Recuperação total do ambiente

### Recuperação Total

Mesmo perdendo tudo no Mac, você pode recuperar:

1.  Clone este repositório
2.  Execute `./scripts/install.sh`
3.  Configure secrets: `~/.zshrc.secrets`
4.  Ambiente restaurado

## Estrutura

```text
neo-dev/
├── README.md                    # Este arquivo
├── standards/                   # Padrões e regras
│   ├── README.md
│   ├── ai.rules.md              # Regras para IA
│   ├── markdown.rules.md        # Regras Markdown
│   ├── zshrc.rules.md           # Regras shell
│   └── ...
├── scripts/
│   └── install.sh               # Instalação completa
├── projects/                    # Projetos ativos
│   └── playground/
├── infra/                       # Infraestrutura
├── scratch/                     # Rascunhos temporários
└── mcp-servers.json.template     # Template MCP Servers
```

## Quick Start

### 1. Clonar o repositório

```bash
cd ~/CODIGOS
git clone [seu-repo] neo-dev
cd neo-dev
```

### 2. Executar instalação

```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

### 3. Configurar secrets

```bash
# O script cria automaticamente se não existir
# Edite e adicione suas API keys
cursor ~/.zshrc.secrets
# ou
code ~/.zshrc.secrets
```

### 4. Recarregar shell

```bash
source ~/.zshrc
```

## Workflows

### WF-01: Padronização

Ao criar novos padrões:

1.  Documente em `standards/`
2.  Atualize este README
3.  Commit com mensagem descritiva

### WF-02: Backup e Recuperação

**Backup automático:**

-  O script `install.sh` cria backups em `~/.config/neo_mello/backups/`
-  Todos os arquivos modificados são salvos antes de alteração

**Recuperação completa:**

```bash
# 1. Clone o repositório
git clone [seu-repo] neo-dev
cd neo-dev

# 2. Execute instalação
./scripts/install.sh

# 3. Configure secrets
cursor ~/.zshrc.secrets

# 4. Recarregue shell
source ~/.zshrc
```

**Ver backups:**

```bash
ls -lh ~/.config/neo_mello/backups/
```

### WF-03: Novos Projetos

Ao iniciar novo projeto:

1.  Crie em `projects/nome-do-projeto/`
2.  Siga os padrões em `standards/`
3.  Documente no README do projeto

## Segurança

### ⚠️ NUNCA versionar

-  `~/.zshrc.secrets` - API keys e tokens
-  Arquivos com credenciais reais
-  Tokens de acesso pessoal

### ✅ Sempre versionar

-  Templates (`.template` suffix)
-  `mcp-servers.json.template` - Template MCP (sem secrets)
-  Configurações públicas
-  Scripts de automação

## MCP Servers (Multi-Client Protocol)

O Cursor suporta MCP Servers para integração com ferramentas externas.

### Configuração Automática

O script `install.sh` configura automaticamente:

1.  **thirdweb-api**: API para operações blockchain
    -  Requer `THIRDWEB_SECRET_KEY` em `~/.zshrc.secrets`
    -  O script substitui automaticamente o placeholder

2.  **GitKraken**: Integração com GitKraken CLI
    -  Requer `gk` instalado: `brew install gitkraken-cli`
    -  Configuração automática via `gk mcp install cursor`

### Configuração Manual

Se precisar configurar manualmente:

1.  Copie o template:

   ```bash
   cp mcp-servers.json.template ~/Library/Application\ Support/Cursor/User/mcp-servers.json
   ```

2.Substitua o placeholder:

   ```bash
   # Obter secret key
   grep THIRDWEB_SECRET_KEY ~/.zshrc.secrets
   
   # Editar manualmente
   cursor ~/Library/Application\ Support/Cursor/User/mcp-servers.json
   ```

3.Reinicie o Cursor para carregar os MCP servers

### Verificar MCP Servers

Após reiniciar o Cursor, os MCP servers devem aparecer automaticamente. Verifique os logs em:

```bash
ls -la ~/Library/Application\ Support/Cursor/logs/
```

## Sincronização Multi-Máquina

### Via Git (Recomendado)

```bash
# Máquina 1: Commit changes
git add .
git commit -m "feat: update standards/configs"
git push

# Máquina 2: Pull e aplicar
git pull
./scripts/install.sh
source ~/.zshrc
```

**Importante:** Este repositório é seu backup completo. Mantenha sempre atualizado no Git para garantir recuperação total.

## Padrões e Standards

Todos os padrões estão em `standards/`:

-  `markdown.rules.md` - Regras de formatação Markdown
-  `ai.rules.md` - Regras para uso de IA
-  `zshrc.rules.md` - Regras de shell
-  `HOW_CURSOR_READS.md` - Como o Cursor lê este workspace
-  `extensions.txt` - Lista de extensões Cursor/VS Code

**Sempre consulte antes de criar novos padrões.**

## Extensões Cursor/VS Code

Lista completa de extensões organizadas por categoria em `standards/extensions.txt`.

**Total: 47 extensões ativas** (9 removidas: Java, Django, Deno) organizadas em:

-  Core/Essenciais (4)
-  Git/Versionamento (4)
-  Python (10)
-  JavaScript/TypeScript (4)
-  Web/Frontend (4)
-  Docker/Containers (3)
-  Jupyter (5)
-  Java (7)
-  E outras categorias...

**Instalar todas as extensões:**

```bash
cat standards/extensions.txt | grep -v "^#" | grep -v "^$" | xargs -L 1 cursor --install-extension
```

**Atualizar lista de extensões:**

```bash
cursor --list-extensions > standards/extensions.txt
```

## Troubleshooting

### Secrets não carregam

```bash
# Verificar se arquivo existe
ls -la ~/.zshrc.secrets

# Recarregar shell
source ~/.zshrc

# Verificar variáveis
env | grep -i api
```

### Scripts não executam

```bash
# Dar permissão
chmod +x scripts/*.sh

# Verificar sintaxe
bash -n scripts/install.sh
```

## Manutenção

### Atualizar padrões

```bash
# Edite arquivos em standards/
# Commit e push
git add standards/
git commit -m "docs: update standards"
git push
```

### Backup manual

Backups são criados automaticamente pelo `install.sh`, mas você pode verificar:

```bash
ls -lh ~/.config/neo_mello/backups/
```

### Limpeza

```bash
# Limpar rascunhos antigos
rm -rf scratch/*

# Limpar node_modules (se necessário)
find projects/ -name node_modules -type d -prune -exec rm -rf {} +
```

## Contribuindo

Este é um repositório pessoal, mas mudanças são permitidas seguindo:

1.  Commit messages descritivos
2.  Testes antes de push
3.  Documentação atualizada

**Inconsistência não é permitida.**

---

## Contact

[neo@neoprotocol.space](mailto:neo@neoprotocol.space)

</div>

<div align="center">
  <a href="https://x.com/node_mello">
    <img src="https://img.shields.io/badge/-@node_mello-ff008e?style=flat-square&logo=twitter&logoColor=white" alt="Twitter @node_mello" />
  </a>
  <a href="https://www.instagram.com/neoprotocol.eth/">
    <img src="https://img.shields.io/badge/-@neoprotocol.eth-ff008e?style=flat-square&logo=instagram&logoColor=white" alt="Instagram @neoprotocol.eth" />
  </a>
  <a href="https://etherscan.io/">
    <img src="https://img.shields.io/badge/-neomello.eth-ff008e?style=flat-square&logo=ethereum&logoColor=white" alt="Ethereum neomello.eth" />
  </a>
</div>

<div align="center">
  <i>"Expand until silence becomes structure."</i>
</div>
