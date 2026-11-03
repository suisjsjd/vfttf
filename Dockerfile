# Staxa-compatible wrapper around the official 9Router container.
# Staxa builds this repository using Buildah and deploys the resulting image.
FROM decolua/9router:latest

ENV PORT=20128 \
    HOSTNAME=0.0.0.0 \
    DATA_DIR=/app/data \
    NODE_ENV=production \
    AUTH_COOKIE_SECURE=true \
    BASE_URL=https://sc-xzc.staxa.app

EXPOSE 20128

# Keep the upstream image's ENTRYPOINT and CMD.
