# Scalar API Starter

Projeto inicial com OpenAPI, Solidity, IPFS e Scalar - baixo atrito, alto retorno.

## 🚀 O que está incluído

- ✅ Exemplo mínimo de OpenAPI 3.1
- ✅ Validador simples de OpenAPI (local)
- ✅ Contratos Solidity para NFT e Token
- ✅ Utilitários para integração com IPFS
- ✅ Pronto para usar com Scalar

## 📋 Pré-requisitos

- Node.js 18+
- IPFS instalado e rodando (`ipfs daemon`)
- Hardhat ou Foundry (para deploy de contratos)

## 🛠️ Instalação

```bash
npm install
```

## 📝 Uso

### Validar OpenAPI spec

```bash
npm run validate
# ou
node validate-openapi.js openapi.yaml
```

### Adicionar metadados ao IPFS

```javascript
const { addJSONToIPFS, generateNFTMetadata } = require('./ipfs-utils');

const metadata = generateNFTMetadata({
  name: 'Meu NFT',
  description: 'Descrição do NFT',
  image: 'ipfs://QmHash...',
  attributes: [
    { trait_type: 'Rarity', value: 'Common' }
  ]
});

const hash = await addJSONToIPFS(metadata);
console.log(`IPFS Hash: ${hash}`);
```

## 📁 Estrutura

```
scalar-api-starter/
├── openapi.yaml          # Spec OpenAPI completa
├── validate-openapi.js   # Validador local
├── contracts/            # Contratos Solidity
│   ├── NeoToken.sol     # Token ERC20
│   └── NeoNFT.sol       # NFT ERC721 com IPFS
├── ipfs-utils.js        # Utilitários IPFS
└── package.json
```

## 🔗 Integração com Scalar

1. Abra o Scalar
2. Importe o arquivo `openapi.yaml`
3. Pronto! Sua documentação está disponível

## 📚 Próximos passos

- [ ] Adicionar testes
- [ ] Criar scripts de deploy
- [ ] Adicionar exemplos de uso
- [ ] Integrar com Hardhat/Foundry

## 👤 Autor

MELLØ // POST-HUMAN

This project follows my personal working standards.
Changes are allowed, inconsistency is not.

