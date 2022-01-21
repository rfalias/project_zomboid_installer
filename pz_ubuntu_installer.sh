#!/bin/bash
#######################################
#
#  Install Project Zomboid Server
#  Use -p flag to set custom password
#  Written by: Jared S.
#
#######################################
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
usage() { echo "Usage: $0 [-p <string>]" 1>&2; exit 1; }

while getopts ":p:" o; do
    case "${o}" in
        p)
            p=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${p}" ]; then
	p=$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-8} | head -n 1)
fi



useradd -m steam
add-apt-repository multiverse
dpkg --add-architecture i386
apt update
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections
apt install lib32gcc1 steamcmd screen -y
su - steam -c 'steamcmd +login anonymous +app_update 380870 +quit +validate'

read -r -d '' VAR <<-EOF
[Unit]
Description=Project Zomboid 41.6x server

[Service]
Type=simple
User=steam
WorkingDirectory=/home/steam/pz_server
Environment=PATH=/home/steam/pz_server/jre64/bin:\$\$PATH
Environment=LD_LIBRARY_PATH=/home/steam/pz_server/linux64:/home/steam/pz_server/natives:/home/steam/pz_server:/home/steam/pz_server/jre64/lib/amd64:\$\$LD_LIBRARY_PATH
ExecStart=/usr/bin/screen -DmS pzserver /home/steam/pz_server/ProjectZomboid64 -adminpassword ${p}
ExecStop=/usr/bin/screen -S pzserver -X quit



[Install]
WantedBy=multi-user.target
Alias=pzserver
EOF
su - steam -c 'ln -s "/home/steam/.steam/steamapps/common/Project Zomboid Dedicated Server" /home/steam/pz_server'
echo -e "$VAR" > /etc/systemd/system/Project-Zomboid.service
echo -e "${RED}######## STOP! READ BELOW FIRST ########"
echo -e "${GREEN}You must configure your server and sandbox settings first!"
echo -e "${GREEN}Run 'su - steam', server and save files are in /home/steam/Zomboid"
echo -e "${GREEN}Project zomboid server with admin password ${RED}${p} ${GREEN}was configured"
echo -e "${GREEN}All server configurations are stored in /home/steam/pz_server"
echo -e "${GREEN}Please see the PZ server wiki for more help at https://pzwiki.net/wiki/Dedicated_Server"
echo -e "${GREEN}To start the server, run 'sudo systemctl start Project-Zomboid'"
echo -e "${NC}"

