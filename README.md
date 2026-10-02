# Portfolio — a theme for Kometio

An editorial theme for studios, designers and photographers: warm paper,
near-black ink, one terracotta accent, headings set in Fraunces and text in
Instrument Sans, with room around everything.

It is also the reference for keeping a [Kometio](https://github.com/kometio/kometio)
theme in its own repository: nothing here is special to this theme except
its tokens and its two regions.

## What is in it

| File | What it does |
| --- | --- |
| `theme.css` | The design tokens: colours, type, spacing, shadows |
| `fonts.css`, `fonts/` | Fraunces and Instrument Sans, as files of the theme |
| `regions/Header.astro` | A thin header with a hairline, translucent when sticky |
| `regions/Footer.astro` | The footer turned over: ink background, paper text |
| `theme.json` | The manifest |
| `Dockerfile` | Builds the theme into Kometio's images |

## Upload it

The simplest way: download this repository as a zip (GitHub's **Code →
Download ZIP** works as it comes) and upload it in the editor's Style
settings, under **Upload a theme**. Kometio builds the site with it on its
own, then offers to use it for the site. The theme's name comes from
`name` in `theme.json`.

## Build it

To ship the theme inside your own images instead:

```sh
docker build --target public-site -t my-agency/kometio-public-site .
docker build --target api -t my-agency/kometio-api .
```

The build runs on Kometio's published `kometio-public-site-builder` image, so it
needs no Kometio checkout. `KOMETIO_TAG` picks the Kometio version (default
`main`); the three Kometio images must share it. The two images replace
Kometio's `public-site` and `api` in its `docker-compose.prod.yml`; the editor
image is Kometio's own. Then choose **Portfolio** in the editor's Style
settings.

This repository's CI builds both on every pull request and publishes them
from `main` as `ghcr.io/kometio/kometio-theme-portfolio-public-site` and
`ghcr.io/kometio/kometio-theme-portfolio-api`, for `linux/amd64` and
`linux/arm64` like Kometio's own images.

## Work on it

Copy it into a Kometio checkout and build the site with it (Kometio's
`docs/creating-a-theme.md`, "Developing it outside this repo"):

```sh
rsync -a --delete --exclude node_modules --exclude .git ./ ../kometio/themes/portfolio/
cd ../kometio
node tools/build-public-site-with-theme.mjs portfolio
node --env-file=.env apps/public-site/server.mjs
```

## Fonts

Fraunces and Instrument Sans are licensed under the SIL Open Font License
1.1; the licences are in `fonts/`.
