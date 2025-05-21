#!/bin/bash
set -e

echo "🔧 Updating APT..."
sudo apt-get update

echo "📦 Installing Python + pip if needed..."
sudo apt-get install -y python3 python3-pip

echo "🐍 Installing Python packages..."
pip3 install --upgrade pip
pip3 install robotframework robotframework-browser

echo "🎭 Initializing Robot Framework Browser (Playwright)..."
rfbrowser init

echo "✅ Setup complete."
