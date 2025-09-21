#!/bin/bash

echo "Customizing GUI..."
gsettings set org.gnome.shell.extensions.pop-shell active-hint true
gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true
gsettings set org.gnome.shell.extensions.pop-shell active-hint-border-radius 3
gsettings set org.gnome.shell.extensions.pop-shell show-title false
gsettings set org.gnome.shell.extensions.pop-shell smart-gaps true

echo "Resetting default keybindings GUI..."
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-down "@as []"	
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-left "@as []"
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-right "@as []"
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-up "@as []"
gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-down "@as []"
gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-up "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-down "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-left "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-right "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-up "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-down "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-left "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-right "@as []"
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-up "@as []"
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking "@as []"
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "@as []"
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "@as []"

echo "Customizing key bindings..."
gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super><Shift>Return', '<Super><Shift>KP_Enter']"
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['<Super>h']"
gsettings set org.gnome.shell.extensions.pop-shell toggle-floating "['<Ctrl><Super>space']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-left "['<Super><Shift>Left', '<Super><Shift>KP_Left', '<Super><Shift>h']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-right "['<Super><Shift>Right', '<Super><Shift>KP_Right', '<Super><Shift>l']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-up "['<Super><Shift>Up', '<Super><Shift>KP_Up', '<Super><Shift>k']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-down "['<Super><Shift>Down', '<Super><Shift>KP_Down', '<Super><Shift>j']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-left-global "['<Super><Shift>Left', '<Super><Shift>KP_Left', '<Super><Shift>h']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-right-global "['<Super><Shift>Right', '<Super><Shift>KP_Right', '<Super><Shift>l']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-up-global "['<Super><Shift>Up', '<Super><Shift>KP_Up', '<Super><Shift>k']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-down-global "['<Super><Shift>Down', '<Super><Shift>KP_Down', '<Super><Shift>j']"

echo "Done."
echo "=========="
echo "IMPORTANT: Log out and log back in before continuing."

gnome-session-quit --logout

