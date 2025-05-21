#!/bin/bash
set -e

echo "🔧 Setting DISPLAY variable..."
echo "export DISPLAY=:1" >> ~/.bashrc
export DISPLAY=:1

echo "📦 Installing dependencies..."
apt-get update
apt-get install -y python3-pip python3-dev
pip3 install --upgrade pip
pip3 install robotframework robotframework-browser
rfbrowser init

echo "✅ Ready! Open /vnc.html on port 6080 to see GUI tests."
