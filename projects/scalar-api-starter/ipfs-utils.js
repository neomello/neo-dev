/**
 * Utilitários para integração com IPFS
 * Requer IPFS instalado e rodando localmente
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const IPFS_CMD = 'ipfs';

/**
 * Verifica se IPFS está disponível
 */
function isIPFSAvailable() {
  try {
    execSync(`${IPFS_CMD} version`, { stdio: 'ignore' });
    return true;
  } catch (error) {
    return false;
  }
}

/**
 * Adiciona dados JSON ao IPFS
 * @param {object} data - Dados JSON para adicionar
 * @returns {Promise<string>} Hash IPFS
 */
async function addJSONToIPFS(data) {
  if (!isIPFSAvailable()) {
    throw new Error('IPFS não está disponível. Certifique-se de que está instalado e rodando.');
  }

  // Criar arquivo temporário
  const tempFile = path.join(__dirname, '.temp-ipfs.json');
  fs.writeFileSync(tempFile, JSON.stringify(data, null, 2));

  try {
    // Adicionar ao IPFS
    const output = execSync(`${IPFS_CMD} add -q ${tempFile}`, { encoding: 'utf-8' });
    const hash = output.trim();

    // Remover arquivo temporário
    fs.unlinkSync(tempFile);

    return hash;
  } catch (error) {
    // Limpar em caso de erro
    if (fs.existsSync(tempFile)) {
      fs.unlinkSync(tempFile);
    }
    throw new Error(`Erro ao adicionar ao IPFS: ${error.message}`);
  }
}

/**
 * Adiciona arquivo ao IPFS
 * @param {string} filePath - Caminho do arquivo
 * @returns {Promise<string>} Hash IPFS
 */
async function addFileToIPFS(filePath) {
  if (!isIPFSAvailable()) {
    throw new Error('IPFS não está disponível.');
  }

  if (!fs.existsSync(filePath)) {
    throw new Error(`Arquivo não encontrado: ${filePath}`);
  }

  try {
    const output = execSync(`${IPFS_CMD} add -q ${filePath}`, { encoding: 'utf-8' });
    return output.trim();
  } catch (error) {
    throw new Error(`Erro ao adicionar arquivo ao IPFS: ${error.message}`);
  }
}

/**
 * Lê dados do IPFS
 * @param {string} hash - Hash IPFS
 * @returns {Promise<object>} Dados JSON
 */
async function getFromIPFS(hash) {
  if (!isIPFSAvailable()) {
    throw new Error('IPFS não está disponível.');
  }

  try {
    const output = execSync(`${IPFS_CMD} cat ${hash}`, { encoding: 'utf-8' });
    return JSON.parse(output);
  } catch (error) {
    throw new Error(`Erro ao ler do IPFS: ${error.message}`);
  }
}

/**
 * Gera metadados padrão para NFT
 * @param {object} params - Parâmetros do NFT
 * @returns {object} Metadados no formato padrão
 */
function generateNFTMetadata({ name, description, image, attributes = [] }) {
  return {
    name,
    description,
    image,
    attributes,
    external_url: '',
    animation_url: '',
  };
}

module.exports = {
  isIPFSAvailable,
  addJSONToIPFS,
  addFileToIPFS,
  getFromIPFS,
  generateNFTMetadata,
};

