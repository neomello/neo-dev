# Templates de Configuração - Editores

## mcp-servers.json

Template para configuração de MCP Servers no Cursor/VS Code.

### Servidores Configurados

- **thirdweb-api**: API thirdweb para operações blockchain
  - Operações de wallet, contratos, tokens, NFTs
  - Requer `THIRDWEB_SECRET_KEY` do `.zshrc.secrets`

- **GitKraken**: Operações Git/GitHub via MCP
  - 19 ferramentas disponíveis
  - 1 prompt disponível

### Instalação

O arquivo será copiado automaticamente pelo script `install.sh`:

```bash
./scripts/install.sh
```

### Instalação Manual

1. Copie o arquivo para:
   ```bash
   cp infra/editors/mcp-servers.json ~/Library/Application\ Support/Cursor/User/mcp-servers.json
   ```

2. **IMPORTANTE**: Substitua `YOUR_THIRDWEB_SECRET_KEY` pela sua chave real:
   ```bash
   # A chave está em ~/.zshrc.secrets como THIRDWEB_SECRET_KEY
   # Edite o arquivo e substitua o placeholder
   cursor ~/Library/Application\ Support/Cursor/User/mcp-servers.json
   ```

2. Ou use o comando GitKraken:
   ```bash
   gk mcp install cursor
   ```

### Verificação

Após instalar, verifique os logs do MCP:
```bash
tail -f ~/Library/Application\ Support/Cursor/logs/*/window*/exthost/anysphere.cursor-mcp/MCP\ user-GitKraken.log
```

Última atualização: 2025-12-26

