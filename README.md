# 42-tiling-manager-setup

42 School computers run a fork of Ubuntu (currently 22.04.3 LTS Jammy Jellyfish):
- Desktop environmennt is Gnome 42.9
- Users do not have sudo privileges: apt-get cannot be used to install any software
- Users have only access to a network-mounted Home
- Users do not have the ability to select another Desktop environment on login screen
- Any customization (settings, preferences, user binaries) have to be made within the user space

The provided scripts customizes the system to achieve an i3-wm like experience.

It leverages [Pop Shell](https://github.com/pop-os/shell?tab=readme-ov-file#pop-shell) Gnome extension from system76 OS. ([docs](https://support.system76.com/articles/pop-keyboard-shortcuts/))

## How to install

Execute the scripts with `bash`:
```bash
bash 0-backup-home.sh // Optional
bash 1-gnome-config.sh
bash 2-install-pop-shell.sh
bash 3-configure-pop-shell.sh
```
Note that a user logout is *required between each script*.

## Default terminal (Super+Return)

You can change the terminal used by default with:
```bash
gsettings set org.gnome.desktop.default-applications.terminal exec '/usr/bin/gnome-terminal'
```
