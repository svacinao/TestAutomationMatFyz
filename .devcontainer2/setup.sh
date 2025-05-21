#!/bin/bash
set -e

echo "🔧 Updating system..."
sudo apt-get update

echo "📦 Installing required packages..."
sudo apt-get install -y \
    python3 python3-pip \
    xvfb x11-utils

echo "🐍 Installing Robot Framework + Browser..."
pip3 install --upgrade pip
pip3 install robotframework robotframework-browser

echo "🎭 Initializing Robot Framework Browser (Playwright)..."
rfbrowser init

echo "✅ Setup complete."

