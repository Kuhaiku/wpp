# Atende • WhatsApp + Evolution API v2

Painel estático pronto para EasyPanel via Dockerfile/Nginx.

## Estrutura

```text
.
├── Dockerfile
├── docker-entrypoint.sh
├── nginx.conf
├── index.html
├── assets/
│   ├── app.css
│   └── app.js
└── README.md
```

## Variáveis de ambiente

No EasyPanel, configure:

- `EVOLUTION_API_URL` = URL base da Evolution API
- `EVOLUTION_API_KEY` = API key
- `EVOLUTION_INSTANCE` = nome da instância
- `POLLING_MS` = intervalo das mensagens (padrão 4000)
- `CHATS_TAKE` = máximo de chats por carga (padrão 500)
- `MESSAGES_TAKE` = máximo de mensagens por carga (padrão 500)

## Deploy no EasyPanel

1. Crie um serviço apontando para o repositório Git.
2. O serviço usa o `Dockerfile` da raiz.
3. Porta interna: `80`.
4. Configure as variáveis de ambiente acima.
5. Adicione o domínio desejado.
6. Faça o deploy.

## Build local

```bash
docker build -t atende-whatsapp .
docker run --rm -p 8080:80 \
  -e EVOLUTION_API_URL="https://sua-evolution.example.com" \
  -e EVOLUTION_API_KEY="SUA_CHAVE" \
  -e EVOLUTION_INSTANCE="mega-xerox" \
  atende-whatsapp
```

Abra `http://localhost:8080`.

## Recursos

- Ativos / Arquivados
- Busca por nome e número
- Histórico via `findMessages`
- Polling inteligente
- Envio de texto via `sendText`
- Envio de mídia/Base64 via `sendMedia`
- Download via `getBase64FromMediaMessage`
- Normalização de JIDs e `@lid`
- Parser tolerante a wrappers do Baileys
- Responsividade mobile
- Painel de detalhes do contato

## Importante sobre segurança

Esta versão é ideal para você colocar no ar e testar. Como a comunicação é direta do navegador com a Evolution API, a apikey ainda fica acessível ao browser.

Para produção com múltiplos operadores, autenticação, auditoria, WebSocket e segurança real, a próxima etapa deve ser um backend/proxy (por exemplo Next.js API ou Node) entre o navegador e a Evolution API.
