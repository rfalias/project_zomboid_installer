# project_zomboid_installer
Install project zomboid server and systemd unit for ubuntu

# Usage
Installs a PZ server for ubuntu. Simply run sudo bash ./pz_ubuntu_installer.sh

By default, it will generate an admin password. Otherwise you can specify a password with pz_ubuntu_installer.sh -p MyPassword

Once installed, you must configure your PZ server. See the wiki page for server options

https://pzwiki.net/wiki/Dedicated_Server


# Manage
SSH to your server, and run:

```
su - steam
screen -r
```

This will have your terminal at the PZ admin prompt, where server commands can be entered. 

To safely disconnect, press CTRL + A then CTRL + D
