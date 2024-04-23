#!/bin/sh
echo -e "\n ------> Run with ROOT permissions !!! <------"
echo -e " ---> run command: sudo sh $0   <---"
echo -e "\n"

echo -e "\n Type 1 for apollolake"
echo -e "\n Type 2 for braswell"
echo -e "\n Type 3 for broadwell"
echo -e "\n Type 4 for broadwellnk"
echo -e "\n Type 5 for denverton"
echo -e "\n Type 6 for geminilake"
echo -e "\n Type 7 for r1000"
echo -e "\n Type 8 for v1000"
echo -e "\n Type 9 to uninstall"

read -p "Your option : " option

# Check the username and password are valid or not
if (( $option == "1" ))
    then
        cp ./7.2/apollolake.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "2" ))
    then
        cp ./7.2/braswell.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "3" ))
    then
        cp ./7.2/broadwell.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "4" ))
    then
        cp ./7.2/broadwellnk.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "5" ))
    then
        cp ./7.2/denverton.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "6" ))
    then
        cp ./7.2/geminilake.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "7" ))
    then
        cp ./7.2/r1000.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "8" ))
    then
        cp ./7.2/v1000.ko /lib/modules/wireguard.ko > ./log.txt 2>&1

elif (( $option == "9" ))
    then
        rmmod /lib/modules/wireguard.ko
        rm -i /lib/modules/wireguard.ko
        rm -i /usr/local/etc/rc.d/wireguard.sh

else
   echo " No valid option selected "
   echo " type any key to exit "
   read -t 15
   exit
fi

chmod 644 /lib/modules/wireguard.ko >> ./log.txt 2>&1

# register the module
insmod /lib/modules/wireguard.ko >> ./log.txt 2>&1

#autorun at next restart
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

if [ -s "log.txt" ]
then
 echo -e "\n "
 echo -e "\nCheck file log.txt for errors !"
 echo -e "\n "
else
 echo -e "\n ================================================"
 echo "---> Wireguard module installed succesfully <---"
 echo -e "\n ================================================"
fi
