# project_zomboid_installer
Install the STEAM version Project Zomboid dedicated server and systemd unit for Ubuntu 20.x

This was not tested on other distros. Some package deps may not work on older versions of ubuntu.

To quickly and UNSAFELY install this, simply run

```
curl https://raw.githubusercontent.com/rfalias/project_zomboid_installer/main/pz_ubuntu_installer.sh | sudo bash
```
Piping curl to bash is UNSAFE. READ THE CODE FIRST!


# Usage
Installs a PZ server for Ubuntu 20.x. Simply run sudo bash ./pz_ubuntu_installer.sh

By default, it will generate an admin password. Otherwise you can specify a password with pz_ubuntu_installer.sh -p MyPassword -u CustomUser

If you do not specify a user, it will create the 'steam' user for you.

Once installed, you must configure your PZ server. See the wiki page for server options

https://pzwiki.net/wiki/Dedicated_Server

Once you configure your server options, you can start your server by running

```
sudo systemctl start Project-Zomboid
```

# Manage
SSH to your server, and run:

```
su - steam
screen -r
```

This will have your terminal at the PZ admin prompt, where server commands can be entered. 

To safely disconnect with out interrupting the server, press CTRL + A then CTRL + D


# Scheduled reboots
Scheduled reboots are common. As the root user, add an entry into crontab, (use the command crontab -e)

Find your crontab time: https://crontab.guru

Example server reset at midnight:

```
0 0 * * * systemctl restart Project-Zomboid


```

# Issues
Report issues to the repo. This is a classic 'it works on my system'. I'll fix what I can.
