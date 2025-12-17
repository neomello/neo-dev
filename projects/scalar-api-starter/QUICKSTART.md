# 🚀 Quick Start

Tudo está configurado e funcionando! Aqui estão os comandos úteis:

> **⚠️ Importante**: Execute os comandos dentro do diretório `projects/scalar-api-starter`
>
> ```bash
> cd projects/scalar-api-starter
> ```

## ✅ Validação

```bash
# Validar OpenAPI spec
npm run validate

# Validar em modo watch (auto-validar ao salvar)
npm run validate:watch
```

## 📤 IPFS

```bash
# Testar integração com IPFS
npm run ipfs:example
```

## 📖 Scalar

### Opção 1: Scalar App (GUI)
```bash
# Tenta abrir no Scalar App
npm run scalar:open

# Se não funcionar, abra manualmente:
# 1. Abra o Scalar App
# 2. File > Open > selecione openapi.yaml
```

### Opção 2: Scalar CLI (Recomendado)
```bash
# Servidor local na porta 3000
npm run scalar:cli

# Depois acesse: http://localhost:3000
```

### Opção 3: Scalar CLI (porta padrão)
```bash
npm run scalar:serve
```

## 🎯 Fluxo Completo

1. **Editar** `openapi.yaml`
2. **Validar** com `npm run validate`
3. **Visualizar** no Scalar com `npm run scalar:open`
4. **Testar IPFS** com `npm run ipfs:example`

## 📝 Exemplo Real

```bash
# 1. Validar spec
npm run validate

# 2. Abrir no Scalar
npm run scalar:open

# 3. Testar upload de metadados NFT
npm run ipfs:example
```

## 🔗 Links Úteis

- **IPFS Gateway**: https://ipfs.io/ipfs/QmcTcnjfcGmCvZgBnAoSuSwB5MN5NsKEYPYCaZG3VXoJGd
- **Scalar Docs**: https://scalar.com/docs

---

**Status**: ✅ Tudo funcionando!
- ✅ OpenAPI spec válido
- ✅ IPFS rodando e testado
- ✅ Scalar instalado e pronto

