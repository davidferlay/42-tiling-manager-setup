
#!/bin/bash
set -euo pipefail

# --- Backup current gsettings ---
gsettings list-recursively > "$HOME/gsettings-backup-$(date +%s).txt"

# --- Show current keyboard layouts (from GNOME input sources) ---
echo "Detecting current keyboard layouts (GNOME input sources)…"
CURRENT_SOURCES="$(gsettings get org.gnome.desktop.input-sources sources || true)"
echo "Current input sources: ${CURRENT_SOURCES:-<unknown>}"

# --- Ask the user which layout to use for workspace shortcuts ---
echo
echo "Choose the target keyboard layout for workspace shortcuts."
echo "  - Type 'fr' or 'azerty' for French (AZERTY, top row: & é \" ' ( - è _ ç à ) = )"
echo "  - Type 'us' or 'qwerty' for US (QWERTY, top row: 1 2 3 4 5 6 7 8 9 0 - = )"
read -rp "Layout [fr/us]: " LAYOUT_CHOICE_RAW
LAYOUT_CHOICE="${LAYOUT_CHOICE_RAW,,}" # to lowercase

if [[ "$LAYOUT_CHOICE" == "fr" || "$LAYOUT_CHOICE" == "azerty" ]]; then
  TARGET_LAYOUT="fr"
  # Keys representing Super+1..12 on French AZERTY (unshifted symbols on the number row)
  WORKSPACE_KEYS=(ampersand eacute quotedbl apostrophe parenleft minus egrave underscore ccedilla agrave parenright equal)
elif [[ "$LAYOUT_CHOICE" == "us" || "$LAYOUT_CHOICE" == "qwerty" ]]; then
  TARGET_LAYOUT="us"
  # Keys representing Super+1..12 on US QWERTY (number row + - =)
  WORKSPACE_KEYS=(1 2 3 4 5 6 7 8 9 0 minus equal)
else
  echo "Unrecognized choice: '$LAYOUT_CHOICE_RAW'. Defaulting to 'fr' (AZERTY)."
  TARGET_LAYOUT="fr"
  WORKSPACE_KEYS=(ampersand eacute quotedbl apostrophe parenleft minus egrave underscore ccedilla agrave parenright equal)
fi

echo "Using layout: $TARGET_LAYOUT"
echo "Workspace key mapping (1..12): ${WORKSPACE_KEYS[*]}"
echo

# --- Customizing GUI ---
echo "Customizing GUI..."
gsettings set org.gnome.desktop.sound event-sounds false
#gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.desktop.interface enable-animations false
gnome-extensions disable tiling-assistant@ubuntu.com || true
gnome-extensions disable ubuntu-dock@ubuntu.com || true

# --- Resetting default keybindings GUI ---
echo "Resetting default keybindings GUI..."
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "@as []"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "@as []"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings minimize "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "@as []"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-group "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys email "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys help "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-10 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-1 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-2 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-3 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-4 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-5 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-6 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-7 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-8 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-9 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-10 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-1 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-2 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-3 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-5 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-6 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-7 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-8 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-9 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-10 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-1 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-2 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-3 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-4 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-5 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-6 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-7 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-8 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-9 "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut "@as []"
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-text "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant restore-window "@as []"	
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottom-half "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomleft-quarter "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomright-quarter "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-left-half "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-maximize "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-right-half "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-top-half "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-topleft-quarter "@as []"
#gsettings set org.gnome.shell.extensions.tiling-assistant tile-topright-quarter "@as []"
gsettings set org.gnome.shell.keybindings focus-active-notification "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-1 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-2 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-3 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-4 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-5 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-6 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-7 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-8 "@as []"
#gsettings set org.gnome.shell.keybindings open-new-window-application-9 "@as []"
gsettings set org.gnome.shell.keybindings shift-overview-down "@as []"
gsettings set org.gnome.shell.keybindings shift-overview-up "@as []"
gsettings set org.gnome.shell.keybindings toggle-message-tray "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "@as []"
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward "@as []"

# --- Custom key bindings ---
echo "Customizing key bindings..."
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>Return']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>n']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
gsettings set org.gnome.desktop.wm.keybindings close  "['<Ctrl>q', '<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>l']"

# --- Workspaces & overview toggles ---
echo "Customizing workspaces..."
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>space']"
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 12

# Clear GNOME's default Super+<number> application switching (1..9)
for i in {1..9}; do
  gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
done

# --- Apply workspace keybindings based on chosen layout ---
# switch-to-workspace-1..12 : <Super> + key
# move-to-workspace-1..12   : <Super><Shift> + key
for idx in "${!WORKSPACE_KEYS[@]}"; do
  ws_num=$((idx + 1))
  key_name="${WORKSPACE_KEYS[$idx]}"
  gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$ws_num" "['<Super>${key_name}']"
  gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$ws_num" "['<Super><Shift>${key_name}']"
done

echo "Done."


