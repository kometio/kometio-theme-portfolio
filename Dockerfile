# syntax=docker/dockerfile:1
# Builds this theme into Kometio's images — docs/creating-a-theme.md,
# "Shipping it", in the Kometio repository. One tag for all three Kometio
# images: the theme is built on one and runs on the others, and they have
# to be the same Kometio.
ARG KOMETIO=ghcr.io/kometio
ARG KOMETIO_TAG=main

FROM ${KOMETIO}/kometio-public-site-builder:${KOMETIO_TAG} AS build
COPY . themes/portfolio
RUN node tools/build-public-site-with-theme.mjs portfolio

FROM ${KOMETIO}/kometio-public-site:${KOMETIO_TAG} AS public-site
USER root
RUN rm -rf /app/dist
COPY --from=build /workspace/apps/public-site/dist /app/dist
USER kometio

# The API only needs the manifest, to offer the theme in the editor.
FROM ${KOMETIO}/kometio-api:${KOMETIO_TAG} AS api
COPY theme.json themes/portfolio/theme.json
