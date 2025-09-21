#!/bin/bash

# Install node https://nodejs.org/en/download
echo "Installing/Updating NVM and Node.js 22..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v
nvm current
npm -v

# Install tsc https://www.typescriptlang.org/download
if ! command -v tsc >/dev/null 2>&1; then
  echo "Typescript not found. Installing..."
  npm install -g typescript
  tsc -v
fi

# ----- Prerequisite check -----
REQUIRED_CMDS=("git" "node" "tsc" "make" "unzip" "lsb_release")
MISSING_CMDS=()
for cmd in "${REQUIRED_CMDS[@]}"; do
  command -v "$cmd" >/dev/null 2>&1 || MISSING_CMDS+=("$cmd")
done
if [ ${#MISSING_CMDS[@]} -ne 0 ]; then
  echo "Error: The following required commands are missing:"
  for cmd in "${MISSING_CMDS[@]}"; do echo "  - $cmd"; done
  echo "Please install them before running this script."
  exit 1
fi

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
REPO_URL="https://github.com/pop-os/shell.git"
EXT_UUID="pop-shell@system76.com"

mkdir -p "$EXT_DIR"
TMP_DIR=$(mktemp -d)
git clone "$REPO_URL" "$TMP_DIR"

UBUNTU_CODENAME=$(lsb_release -cs 2>/dev/null || echo "focal")
case "$UBUNTU_CODENAME" in
  focal|groovy|hirsute|impish) git -C "$TMP_DIR" checkout master_focal ;;
  jammy|kinetic|lunar)        git -C "$TMP_DIR" checkout master_jammy ;;
  mantic)                     git -C "$TMP_DIR" checkout master_mantic ;;
  noble)                      git -C "$TMP_DIR" checkout master_noble ;;
  *)                          git -C "$TMP_DIR" checkout master_focal ;;
esac

cd "$TMP_DIR"
make local-install

# Copy and compile GSettings schemas for Pop Shell
SCHEMA_SRC="$TMP_DIR/schemas"
SCHEMA_DEST="$HOME/.local/share/glib-2.0/schemas"

if [ -d "$SCHEMA_SRC" ]; then
  mkdir -p "$SCHEMA_DEST"
  cp "$SCHEMA_SRC"/*.gschema.xml "$SCHEMA_DEST"/
  echo "Compiled GSettings schemas:"
  glib-compile-schemas "$SCHEMA_DEST"
else
  echo "Warning: Schema directory '$SCHEMA_SRC' does not exist. Skipping schema installation."
fi

rm -rf "$TMP_DIR"

echo
echo "Reseting custom keybindings removed by install"
set -x 
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>Return']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>n']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
gsettings set org.gnome.desktop.wm.keybindings close  "['<Ctrl>q', '<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
set +x

echo
echo "Pop Shell extension installed in $EXT_DIR/$EXT_UUID"
echo "gnome-extensions list before reload:"
gnome-extensions list 
echo "=========="
echo "IMPORTANT: Log out and log back in before continuing."
echo "Then run 'enable-pop-shell.sh' to enable the extension."

gnome-session-quit --logout

