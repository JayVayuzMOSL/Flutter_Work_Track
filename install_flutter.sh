#!/bin/bash

# Exit on first error
set -e

# Install dependencies
sudo apt-get update -y
sudo apt-get install -y curl unzip git xz-utils zip libglu1-mesa

# Download and install Flutter
FLUTTER_VERSION="3.16.3"  # Update to latest stable version
curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz
tar -xf flutter_linux_$FLUTTER_VERSION-stable.tar.xz

# Move Flutter to home directory
mv flutter $HOME/flutter

# Add Flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

# Enable Flutter for Web
flutter config --enable-web

# Get dependencies
flutter pub get
