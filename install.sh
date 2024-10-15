#!/bin/bash

SCRIPT_NAME="bin/c"
INSTALL_DIR="/usr/local/bin"
LICENSE_FILE="LICENSE"

if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "Error: $SCRIPT_NAME not found in the bin folder."
    exit 1
fi

if [[ ! -f "$LICENSE_FILE" ]]; then
    echo "Error: LICENSE file not found."
    exit 1
fi
echo "The license for this software can be found at $LICENSE_FILE."
echo "You must read and accept the license before proceeding."
read -p "Do you accept the terms of the LICENSE? (y/n): " ACCEPT

if [[ "$ACCEPT" != "y" ]]; then
    echo "Installation aborted. You must accept the LICENSE to install."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "Root privileges are required to install the script."
    sudo echo ""  # Ensure sudo is prompted early
fi

SCRIPT_BASENAME=$(basename "$SCRIPT_NAME")  # Get the actual script file name
echo "Installing $SCRIPT_BASENAME to $INSTALL_DIR"

if [[ -f "$INSTALL_DIR/$SCRIPT_BASENAME" ]]; then
    echo "Error: A file named '$SCRIPT_BASENAME' already exists in $INSTALL_DIR."
    echo "Installation aborted to prevent overwriting the existing file."
    exit 1
fi

sudo cp "$SCRIPT_NAME" "$INSTALL_DIR"

sudo chmod +x "$INSTALL_DIR/$SCRIPT_BASENAME"

if [[ -f "$INSTALL_DIR/$SCRIPT_BASENAME" ]]; then
    echo "Installation successful! You can now run the script using '$SCRIPT_BASENAME'."
else
    echo "Installation failed."
fi

