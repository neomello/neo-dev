#!/usr/bin/env node

/**
 * Exemplo de uso dos utilitários
 */

const { addJSONToIPFS, generateNFTMetadata, isIPFSAvailable } = require('./ipfs-utils');

async function main() {
  console.log('🚀 Exemplo de uso - Scalar API Starter\n');

  // Verificar IPFS
  if (!isIPFSAvailable()) {
    console.log('⚠️  IPFS não está disponível.');
    console.log('   Execute: ipfs daemon\n');
    return;
  }

  console.log('✅ IPFS disponível\n');

  // Exemplo: Gerar metadados de NFT
  console.log('📝 Gerando metadados de NFT...');
  const metadata = generateNFTMetadata({
    name: 'NEØ NFT #1',
    description: 'Primeiro NFT do projeto NEØ',
    image: 'ipfs://QmExampleHash...',
    attributes: [
      { trait_type: 'Rarity', value: 'Legendary' },
      { trait_type: 'Power', value: 100 },
    ],
  });

  console.log('Metadados:', JSON.stringify(metadata, null, 2));
  console.log('\n');

  // Exemplo: Adicionar ao IPFS
  try {
    console.log('📤 Adicionando ao IPFS...');
    const hash = await addJSONToIPFS(metadata);
    console.log(`✅ Adicionado ao IPFS!`);
    console.log(`   Hash: ${hash}`);
    console.log(`   URL: ipfs://${hash}`);
    console.log(`   Gateway: https://ipfs.io/ipfs/${hash}`);
  } catch (error) {
    console.error('❌ Erro:', error.message);
  }
}

main().catch(console.error);

