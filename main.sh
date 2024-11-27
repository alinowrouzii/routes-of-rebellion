#!/bin/bash

# Identify the OS type
OS_TYPE=$(uname -s)

# Ensure the script is running with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root."
  exit 1
fi

# Handle OS-specific execution
case "$OS_TYPE" in
  Darwin)
    echo "Detected macOS. Executing mac-os.sh..."
    if [ -f "./mac-os.sh" ]; then
      ./mac-os.sh
    else
      echo "Error: mac-os.sh not found. Please ensure it is in the same directory."
      exit 1
    fi
    ;;
  Linux)
    echo "Detected Linux. Support coming soon!"
    # TODO: Add Linux support and script execution
    exit 1
    ;;
  *)
    echo "Unsupported OS: $OS_TYPE"
    exit 1
    ;;
esac

echo "Script execution completed."