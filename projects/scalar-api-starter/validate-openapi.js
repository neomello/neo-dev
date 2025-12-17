#!/usr/bin/env node

/**
 * Validador simples de OpenAPI (local)
 * Valida arquivos OpenAPI 3.x usando validação básica
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
};

function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

function validateOpenAPI(filePath) {
  log('\n🔍 Validando OpenAPI spec...', 'blue');
  log(`📄 Arquivo: ${filePath}\n`, 'blue');

  // Verificar se arquivo existe
  if (!fs.existsSync(filePath)) {
    log(`❌ Arquivo não encontrado: ${filePath}`, 'red');
    process.exit(1);
  }

  // Ler e parsear arquivo
  let spec;
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    spec = yaml.load(content);
  } catch (error) {
    log(`❌ Erro ao parsear YAML: ${error.message}`, 'red');
    process.exit(1);
  }

  const errors = [];
  const warnings = [];

  // Validar estrutura básica
  if (!spec.openapi) {
    errors.push('Campo "openapi" é obrigatório');
  } else {
    const version = parseFloat(spec.openapi);
    if (version < 3.0 || version >= 4.0) {
      warnings.push(`Versão OpenAPI ${spec.openapi} pode não ser suportada`);
    }
  }

  if (!spec.info) {
    errors.push('Campo "info" é obrigatório');
  } else {
    if (!spec.info.title) errors.push('info.title é obrigatório');
    if (!spec.info.version) errors.push('info.version é obrigatório');
  }

  if (!spec.paths || Object.keys(spec.paths).length === 0) {
    warnings.push('Nenhum path definido');
  }

  // Validar paths
  if (spec.paths) {
    Object.entries(spec.paths).forEach(([path, methods]) => {
      Object.entries(methods).forEach(([method, operation]) => {
        if (!operation.summary && !operation.description) {
          warnings.push(`Path ${method.toUpperCase()} ${path} sem summary ou description`);
        }

        if (operation.responses && !operation.responses['200'] && !operation.responses['201']) {
          warnings.push(`Path ${method.toUpperCase()} ${path} sem resposta de sucesso (200/201)`);
        }
      });
    });
  }

  // Validar components
  if (spec.components) {
    if (spec.components.schemas) {
      Object.entries(spec.components.schemas).forEach(([name, schema]) => {
        if (!schema.type && !schema.$ref) {
          warnings.push(`Schema "${name}" sem tipo definido`);
        }
      });
    }
  }

  // Exibir resultados
  if (errors.length === 0 && warnings.length === 0) {
    log('✅ OpenAPI spec válido!', 'green');
    log(`\n📊 Estatísticas:`, 'blue');
    log(`   - Paths: ${Object.keys(spec.paths || {}).length}`, 'blue');
    log(`   - Schemas: ${Object.keys(spec.components?.schemas || {}).length}`, 'blue');
    log(`   - Tags: ${(spec.tags || []).length}`, 'blue');
    return true;
  }

  if (errors.length > 0) {
    log('\n❌ Erros encontrados:', 'red');
    errors.forEach((error) => log(`   - ${error}`, 'red'));
  }

  if (warnings.length > 0) {
    log('\n⚠️  Avisos:', 'yellow');
    warnings.forEach((warning) => log(`   - ${warning}`, 'yellow'));
  }

  if (errors.length > 0) {
    process.exit(1);
  }

  return true;
}

// Main
const filePath = process.argv[2] || path.join(__dirname, 'openapi.yaml');

if (!fs.existsSync(filePath)) {
  log(`❌ Arquivo não encontrado: ${filePath}`, 'red');
  log('\n💡 Uso: node validate-openapi.js [caminho-do-arquivo]', 'yellow');
  process.exit(1);
}

validateOpenAPI(filePath);

