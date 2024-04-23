# Install only wireguard module for Synology
for DSM 7.2, tested for DS920+

choose your Synology arhitecture from here:
https://kb.synology.com/en-ca/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have 

You cand choose among foloowing models:
 - apollolake
 - braswell
 - broadwell
 - broadwellnk
 - denverton
 - geminilake
 - r1000
 - v1000


# Install with git  or download the files in Synology
>git clone https://github.com/gpopesc/wireguard-module-synology.git
>
>cd wireguard-module-synology


and run as root user:
>sudo sh ./install_module.sh

in case of eny errors check the screen or log.txt
restart synology if it was uninstalled first.

Further you can install in docker wireguard

https://github.com/WeeJeWel/wg-easy 

or

https://github.com/linuxserver/docker-wireguard 
