#!/bin/bash

# Define variables
SCRIPT_NAME="bin/c"  # Path to your script inside the bin folder
INSTALL_DIR="/usr/local/bin"     # Default installation directory
LICENSE_FILE="LICENSE"           # Path to the LICENSE file

# Check if the script exists
if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "Error: $SCRIPT_NAME not found in the bin folder."
    exit 1
fi

# Check if the LICENSE file exists
if [[ ! -f "$LICENSE_FILE" ]]; then
    echo "Error: LICENSE file not found."
    exit 1
fi

# Inform the user about the license and ask for acceptance
echo "The license for this software can be found at $LICENSE_FILE."
echo "You must read and accept the license before proceeding."
read -p "Do you accept the terms of the LICENSE? (y/n): " ACCEPT

if [[ "$ACCEPT" != "y" ]]; then
    echo "Installation aborted. You must accept the LICENSE to install."
    exit 1
fi

# Ask for sudo privileges if not running as root
if [[ $EUID -ne 0 ]]; then
    echo "Root privileges are required to install the script."
    sudo echo ""  # Ensure sudo is prompted early
fi

# Copy the script to the installation directory
SCRIPT_BASENAME=$(basename "$SCRIPT_NAME")  # Get the actual script file name
echo "Installing $SCRIPT_BASENAME to $INSTALL_DIR"
sudo cp "$SCRIPT_NAME" "$INSTALL_DIR"

# Make the script executable
sudo chmod +x "$INSTALL_DIR/$SCRIPT_BASENAME"

# Confirm installation
if [[ -f "$INSTALL_DIR/$SCRIPT_BASENAME" ]]; then
    echo "Installation successful! You can now run the script using '$SCRIPT_BASENAME'."
else
    echo "Installation failed."
fi

