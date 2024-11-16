#!/bin/bash
echo -e "\n ------> Run with ROOT permissions !!! <------"
echo -e " ---> run command: sudo bash $0 --option <type>   <---"
echo -e " ---> optional: use '--option X' as parameter   <---"
echo -e "\n"

# Define an associative array mapping options to CPU names
declare -A options=(
    [1]="apollolake"
    [2]="braswell"
    [3]="broadwell"
    [4]="broadwellnk"
    [5]="denverton"
    [6]="geminilake"
    [7]="r1000"
    [8]="v1000"
    [9]="uninstall"
)

# Parse command-line arguments
for arg in "$@"; do
    case $arg in
        --option)
            option=$2
            shift 2
            ;;
        *)
            ;;
    esac
done

# If no option provided via CLI, prompt the user
if [ -z "$option" ]; then
    echo -e "\nSelect Option:"
    for key in "${!options[@]}"; do
        echo -e " Type $key for ${options[$key]}"
    done
    read -p "Your option : " option
fi

# Validate the selection
cpu_name=${options[$option]}
if [ -z "$cpu_name" ]; then
    echo "Invalid option selected. Exiting."
    exit 1
fi

# Display the selected option
echo "Option Selected: $cpu_name"

# Perform the action based on the option
if [ "$cpu_name" = "uninstall" ]; then
    rmmod /lib/modules/wireguard.ko
    rm -i /lib/modules/wireguard.ko
    rm -i /usr/local/etc/rc.d/wireguard.sh
else
    cp ./7.2/${cpu_name}.ko /lib/modules/wireguard.ko > ./log.txt 2>&1
    chmod 644 /lib/modules/wireguard.ko >> ./log.txt 2>&1

    # Register the module
    insmod /lib/modules/wireguard.ko >> ./log.txt 2>&1
fi

# Autorun at next restart
if [ "$cpu_name" != "uninstall" ]; then
    tee /usr/local/etc/rc.d/wireguard.sh >> /dev/null <<'HERE'
#!/bin/bash
MODULES_UNLOAD="wireguard.ko"
start_modules(){
    echo "Loading wireguard.ko"
    insmod /lib/modules/wireguard.ko
}
stop_modules(){
    echo "--- Unload modules ---"
    for i in $MODULES_UNLOAD; do
        echo "Unloading $i"
        rmmod $i
    done
}
case "$1" in
start)
    start_modules
    ;;
stop)
    stop_modules
    ;;
*)
    echo "usage: $0 { start | stop }" >&2
    exit 1
    ;;
esac
HERE

    chmod +x /usr/local/etc/rc.d/wireguard.sh >> ./log.txt 2>&1
fi

if [ -s "log.txt" ]; then
    echo -e "\nCheck file log.txt for errors!"
else
    echo -e "\n ================================================"
    echo "---> Wireguard module installed successfully <---"
    echo -e "\n ================================================"
fi
