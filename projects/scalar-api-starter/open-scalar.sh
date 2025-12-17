#!/bin/bash

# Script para abrir Scalar com openapi.yaml
# Funciona melhor que o comando open direto

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENAPI_FILE="${SCRIPT_DIR}/openapi.yaml"

if [ ! -f "$OPENAPI_FILE" ]; then
  echo "❌ Arquivo openapi.yaml não encontrado em: $OPENAPI_FILE"
  exit 1
fi

# Abrir Scalar e passar o arquivo
open -a Scalar "$OPENAPI_FILE"

echo "✅ Abrindo Scalar com: $OPENAPI_FILE"

