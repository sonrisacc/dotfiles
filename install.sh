#!/bin/bash

# Abort on error
set -e

echo "Checking if Homebrew is already installed...";

# Checks if Homebrew is installed
if test ! $(which brew); then
  echo "Installing Homebrew...";
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew is already installed...";
fi

# Install the essential brews
brew install lazygit
# Update and Upgrade
echo "Updating and upgrading Homebrew..."; echo;
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
brew cleanup
