#!/usr/bin/env node

/**
 * Script para publicar documentação no Scalar Docs
 * Usa a API do Scalar ou mostra instruções manuais
 */

const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../../.env') });

const SCALAR_API_KEY = process.env.SCALAR_API_KEY;

if (!SCALAR_API_KEY) {
  console.error('❌ SCALAR_API_KEY não encontrada no .env');
  process.exit(1);
}

const OPENAPI_URL = 'https://raw.githubusercontent.com/neomello/neo-dev/main/projects/playground/openapi.yaml';

console.log('🚀 Publicar Documentação no Scalar\n');
console.log('📋 Instruções:\n');
console.log('1. Acesse: https://dashboard.scalar.com');
console.log('2. Vá em "Docs" (menu lateral)');
console.log('3. Clique em "Create Documentation" ou edite a existente');
console.log('4. Configure a source:\n');
console.log(`   URL: ${OPENAPI_URL}\n`);
console.log('   OU via GitHub:');
console.log('   - Repository: neomello/neo-dev');
console.log('   - Branch: main');
console.log('   - Path: projects/playground/openapi.yaml\n');
console.log('5. Clique em "Publish" ou "Save"\n');
console.log('✨ Pronto! A documentação estará disponível.\n');
console.log('💡 Dica: A API do Scalar não está documentada publicamente.');
console.log('   Use o dashboard para publicar (é mais confiável).\n');
