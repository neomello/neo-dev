# Playground

API mínima para testes e validação.

## Estrutura

- `openapi.yaml` - Spec OpenAPI com 1 endpoint mínimo

## Validação Local

```bash
# Validar OpenAPI
npx @redocly/cli lint openapi.yaml
```

## Endpoint

- `GET /health` - Health check simples

---

**Nota**: Este é um artefato mínimo. Não adicione complexidade até ter necessidade real.

