# 42-tiling-manager-setup

42 School computers run a fork of Ubuntu (currently 22.04.3 LTS Jammy Jellyfish):
- Desktop environmennt is Gnome 42.9
- Users do not have sudo privileges: apt-get cannot be used to install any software
- Users have only access to a network-mounted Home
- Users do not have the ability to select another Desktop environment on login screen
- Any customization (settings, preferences, user binaries) have to be made within the user space

The provided scripts custmizes the system to achieve an i3-wm like experience.
