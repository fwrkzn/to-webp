#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME="to-webp"
INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_PATH="${INSTALL_DIR}/${SCRIPT_NAME}"

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_NAME" "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

SHELL_RC=""
if [ -n "${ZSH_VERSION:-}" ] || [ "${SHELL##*/}" = "zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "${BASH_VERSION:-}" ] || [ "${SHELL##*/}" = "bash" ]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.profile"
fi

if ! echo ":$PATH:" | grep -q ":$INSTALL_DIR:"; then
  echo "" >> "$SHELL_RC"
  echo "# Added by to-webp installer" >> "$SHELL_RC"
  echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_RC"
  echo "Added $INSTALL_DIR to PATH in $SHELL_RC"
fi

echo "Installed to $SCRIPT_PATH"
echo "Restart your terminal or run:"
echo "source \"$SHELL_RC\""
echo
echo "Then use:"
echo "  to-webp"
