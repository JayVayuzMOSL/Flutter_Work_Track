#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define Flutter version (change this if needed)
FLUTTER_VERSION="3.19.0"
FLUTTER_ARCHIVE="flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/${FLUTTER_ARCHIVE}"

# Install dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl unzip xz-utils git

# Download Flutter SDK
echo "Downloading Flutter SDK..."
curl -o $FLUTTER_ARCHIVE $FLUTTER_URL

# Extract Flutter
echo "Extracting Flutter..."
tar -xf $FLUTTER_ARCHIVE

# Move Flutter to the correct location
export PATH="$PWD/flutter/bin:$PATH"

# Verify Flutter installation
echo "Flutter version:"
flutter --version

# Accept Flutter licenses
echo "Accepting Flutter licenses..."
yes | flutter doctor --android-licenses || true

# Run Flutter Doctor
flutter doctor

echo "Flutter installation completed successfully!"
