# Install only wireguard module for Synology
for DSM 7.1, tested for DS920+

# Install with git  or download the files in Synology
>git clone https://github.com/gpopesc/wireguard-module-synology.git
>
>cd wireguard-module-synology

in case you have DSM 7.1, rename wireguard.ko to wireguard_7.2.ko and wireguard_7.1.ko to wireguard.ko

and run as root user:
>sudo sh ./install_module.sh

in case of eny errors check the screen or file log.txt

Further you can install in docker wireguard

https://github.com/WeeJeWel/wg-easy 

or

https://github.com/linuxserver/docker-wireguard 
