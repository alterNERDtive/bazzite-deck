# Custom Bazzite-Deck Image

[![Build Status](https://github.com/alterNERDtive/bazzite-deck/actions/workflows/build.yml/badge.svg)](https://github.com/alterNERDtive/bazzite-deck/actions/workflows/build.yml)

This is my custom Bazzite image for my Steam Deck.

You can build your own at [https://github.com/ublue-os/image-template](https://github.com/ublue-os/image-template).

## Changes compared to base Bazzite

I am way too lazy to make a list and keep it up to date. Just check out the
`build` folder.

## Install

From an existing Bazzite installation switch to the custom image:

```bash
sudo bootc switch --enforce-container-sigpolicy ghcr.io/alterNERDtive/bazzite-deck:latest
```

Afterwards, run

```bash
ujust nerd-install-flatpaks
ujust nerd-install-appimages
```

or

```bash
ujust nerd-install
```

to install my list of … well, those things.
