# Install wireguard module for Synology
for DSM 7.2, tested for DS920+

Choose your Synology arhitecture from here:
https://kb.synology.com/en-ca/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have 

You can choose from following models as an `option`:
 1. apollolake
 2. braswell
 3. broadwell
 4. broadwellnk
 5. denverton
 6. geminilake
 7. r1000
 8. v1000


# Install with git  or download the files in Synology
>git clone https://github.com/gpopesc/wireguard-module-synology.git
>
>cd wireguard-module-synology

and run as root user:
>sudo sh ./install_module.sh

or with the command line parameter selection:
>sudo sh ./install_module.sh --option X

in case of eny errors check the screen or log.txt

restart synology if it was uninstalled first.

# Uninstall

Use option 9 to uninstall. 

# Run using Synology DSM Task Scheduler

1. Open `Control Panel`
2. Go to `Task Scheduler`
3. Press `Create` -> `Scheduled Task` -> `User-defined script`
4. Give it a name like "Install WG Modules" and *uncheck* the `Enabled` checkbox
5. Select `root` as the user
6. The schedule tab can be ignored
7. In task settings enter an email if you want and check `Send run details by email` (you will need email notifications to be configured in DSM)
8. Paste the following user-defined script. Edit the option and temporary path as needed:

```
#!/bin/sh

# Variables
LOCAL_PATH="/volume1/docker/_temp/wireguard-module-synology"
CPU_TYPE="6"

# Remove the existing directory
#rm -R "$LOCAL_PATH"

# Clone the repository
git clone https://github.com/gpopesc/wireguard-module-synology.git "$LOCAL_PATH"

# Navigate to the local path
cd "$LOCAL_PATH"

# Run the installation script
sudo sh ./install_module.sh --option "$CPU_TYPE"

# Echo the log
cat ./log.txt
```

9. Save
10. Select and Run


# Further you can install wireguard in docker

https://github.com/WeeJeWel/wg-easy 

or

https://github.com/linuxserver/docker-wireguard 
