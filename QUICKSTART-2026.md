# Quick Start — NEØ Dev Workspace 2026

**Repositório:** https://github.com/neomello/neo-dev

**Última atualização:** 2025-12-25

---

## Como Usar os Padrões Globalmente

### 1. Clonar o Repositório

```bash
cd ~/CODIGOS
git clone https://github.com/neomello/neo-dev.git
cd neo-dev
```

### 2. Executar Instalação

```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

### 3. Configurar Secrets

```bash
cursor ~/.zshrc.secrets
# ou
code ~/.zshrc.secrets
```

Adicione suas API keys seguindo o padrão em `standards/zshrc.rules.md`.

### 4. Recarregar Shell

```bash
source ~/.zshrc
```

---

## Aplicar Padrões em Novos Projetos

### Para READMEs

1.  Consulte `standards/readme.template.md`
2.  Adicione assinatura de `standards/readme.signature.md` no final
3.  Siga regras em `standards/markdown.rules.md`

### Para Contratos Solidity

1.  Use `standards/contract.template.sol` como base
2.  Siga padrão em `standards/readme.signature.contracts.md`
3.  Use `MELLO` (sem Ø) em comentários

### Via Cursor/IA

O Cursor lê automaticamente `.cursorrules` que referencia todos os padrões.

A IA seguirá automaticamente:
-  Regras de Markdown
-  Padrões de código
-  Templates e assinaturas

---

## Estrutura de Padrões

```
standards/
├── README.md                    # Índice completo
├── WORKFLOW.md                  # Resumo do workflow protocol
├── ai.rules.md                  # Regras para IA
├── markdown.rules.md            # Regras Markdown
├── readme.template.md           # Template README
├── readme.signature.md          # Assinatura projetos
├── readme.signature.contracts.md # Assinatura contratos
├── contract.template.sol        # Template Solidity
├── zshrc.rules.md               # Regras shell
└── ...
```

---

## Documentação Completa

-  **Padrões:** `standards/README.md`
-  **Workflow:** `standards/WORKFLOW.md` (resumo) / `neomello-workflow.md` (completo)
-  **Audit:** `AUDIT-2026.md`
-  **Como Cursor lê:** `standards/HOW_CURSOR_READS.md`

---

## Garantir Uso Global

### Em Novos Projetos

1.  Clone este repositório em sua máquina
2.  Execute `./scripts/install.sh`
3.  Ao criar novo projeto, consulte `standards/` para padrões
4.  Use templates fornecidos

### Sincronização Multi-Máquina

```bash
# Máquina 1: Commit changes
git add .
git commit -m "feat: update standards"
git push

# Máquina 2: Pull e aplicar
git pull
./scripts/install.sh
source ~/.zshrc
```

### Via Cursor

O Cursor aplica automaticamente os padrões quando você:
-  Abre o workspace `neo-dev`
-  Cria novos arquivos seguindo os templates
-  Usa a IA para gerar código/documentação

---

## Importante

-  **Padrões são autoritativos** - Inconsistência não é permitida
-  **Nunca versionar secrets** - Use `~/.zshrc.secrets` (não versionado)
-  **Sempre consulte `standards/`** antes de criar novos padrões
-  **Mantenha atualizado** - Pull regular para ter padrões mais recentes

---

**Repositório:** https://github.com/neomello/neo-dev

**Autor:** MELLØ // POST-HUMAN

