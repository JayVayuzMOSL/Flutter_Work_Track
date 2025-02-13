#!/bin/bash

# Exit on first error
set -e

echo "Updating system packages..."
sudo apt-get update -y
sudo apt-get install -y curl unzip git xz-utils zip libglu1-mesa

echo "Downloading Flutter..."
FLUTTER_VERSION="3.16.3"  # Replace with the latest stable version
curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz

echo "Extracting Flutter..."
tar -xf flutter_linux_$FLUTTER_VERSION-stable.tar.xz

echo "Moving Flutter to Home directory..."
mv flutter $HOME/flutter

echo "Adding Flutter to PATH..."
export PATH="$HOME/flutter/bin:$PATH"

echo "Enabling Flutter Web..."
flutter config --enable-web

echo "Fetching Flutter dependencies..."
flutter pub get

echo "Flutter installed successfully!"
