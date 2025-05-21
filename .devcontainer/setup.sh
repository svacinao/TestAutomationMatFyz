#!/bin/bash
set -e

echo "🔧 Updating apt..."
sudo apt-get update

echo "📦 Installing system dependencies..."
sudo apt-get install -y xvfb

echo "🐍 Installing Python packages..."
pip install --upgrade pip
pip install robotframework robotframework-browser

echo "🎭 Initializing Robot Framework Browser (Playwright)..."
rfbrowser init
