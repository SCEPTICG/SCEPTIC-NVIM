#!/usr/bin/env sh
set -eu

REPO_URL="${SCEPTIC_NVIM_REPO:-https://github.com/SCEPTICG/SCEPTIC-NVIM.git}"
BRANCH="${SCEPTIC_NVIM_BRANCH:-main}"
CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
TARGET_DIR="$CONFIG_HOME/nvim"
TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/sceptic-nvim.XXXXXX")"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git no esta instalado o no esta en PATH." >&2
  exit 1
fi

if [ -e "$TARGET_DIR" ]; then
  BACKUP_DIR="${TARGET_DIR}.backup.$(date +%Y%m%d%H%M%S)"
  echo "Config existente detectada. Backup: $BACKUP_DIR"
  mv "$TARGET_DIR" "$BACKUP_DIR"
fi

echo "Clonando SCEPTIC-NVIM desde $REPO_URL ($BRANCH)..."
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR/repo"

mkdir -p "$CONFIG_HOME"
cp -R "$TMP_DIR/repo/nvim" "$TARGET_DIR"

echo "SCEPTIC-NVIM instalado en: $TARGET_DIR"
echo "Abre Neovim y ejecuta :Lazy sync, :Mason y :checkhealth."
