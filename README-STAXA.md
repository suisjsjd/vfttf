# 9Router on Staxa

This repository is a small Staxa deployment wrapper for the official
`decolua/9router:latest` container. It does not repackage or modify 9Router's
application source; it adds a Dockerfile so Staxa can build the deployment.

## Staxa service settings

- Source: GitHub
- Repository: your fork/replacement repository containing this Dockerfile at its root
- Branch: `main`
- Container port: `20128`
- Resource size: Medium recommended (Small may be insufficient depending on usage)
- Health check type: HTTP
- Health check path: `/api/health`
- Database: None (9Router uses SQLite)

## Environment variables

Set these in Staxa → Tenant → Environment:

```env
PORT=20128
HOSTNAME=0.0.0.0
DATA_DIR=/app/data
NODE_ENV=production
AUTH_COOKIE_SECURE=true
BASE_URL=https://sc-xzc.staxa.app
```

Set these separately as **Secret** variables, using unique strong random values:

- `INITIAL_PASSWORD` — initial 9Router dashboard password. Do not leave the upstream default.
- `JWT_SECRET` — JWT signing secret.
- `API_KEY_SECRET` — HMAC secret for generated API keys.
- `MACHINE_ID_SALT` — stable machine-ID hashing salt.

Do not commit real secrets to GitHub or include them in this ZIP.

If your tenant URL changes, update `BASE_URL` to the actual HTTPS deployment URL.

## Important: persistent data

9Router stores its SQLite database and related state under `/app/data`
when `DATA_DIR=/app/data`. Configure a persistent volume mounted at
`/app/data` if your Staxa plan/UI supports persistent volumes. Without
persistent storage, data may be lost when the container is replaced.

## Deployment

1. Extract this ZIP.
2. Replace the contents of a GitHub repository with the extracted files
   (the `Dockerfile` must be at the repository root).
3. Commit and push to the branch selected in Staxa.
4. In Staxa, select that GitHub repository and deploy.
5. Review build logs if the build fails; after deploy, verify the HTTP
   health check and open the tenant URL.

Official project Docker instructions:
https://github.com/decolua/9router/blob/master/DOCKER.md

Staxa first-deployment guide:
https://staxa.dev/support/articles/first-deployment
