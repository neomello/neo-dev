#!/bin/bash

# Script para publicar documentação no Scalar usando CLI
# Requer: SCALAR_API_KEY no .env

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../../.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Arquivo .env não encontrado em: $ENV_FILE"
  exit 1
fi

# Carregar .env
export $(grep -v '^#' "$ENV_FILE" | xargs)

if [ -z "$SCALAR_API_KEY" ]; then
  echo "❌ SCALAR_API_KEY não encontrada no .env"
  exit 1
fi

echo "🚀 Publicando documentação no Scalar..."
echo ""

cd "$SCRIPT_DIR"

# Usar CLI do Scalar se disponível
if command -v scalar &> /dev/null; then
  echo "📝 Usando Scalar CLI..."
  export SCALAR_API_KEY
  scalar publish openapi.yaml
else
  echo "⚠️  Scalar CLI não encontrado."
  echo ""
  echo "📋 Para publicar manualmente:"
  echo "1. Acesse: https://dashboard.scalar.com"
  echo "2. Vá em Docs > Create Documentation"
  echo "3. Use a URL:"
  echo "   https://raw.githubusercontent.com/neomello/neo-dev/main/projects/playground/openapi.yaml"
  echo ""
  echo "Ou instale o CLI:"
  echo "  npm install -g @scalar/cli"
fi

