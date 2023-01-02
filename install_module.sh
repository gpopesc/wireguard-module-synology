#!/bin/sh
echo -e "\n Run with ROOT permissions !!!"
echo -e "run command: sudo sh $0"
echo -e "\n"
cp ./wireguard.ko /lib/modules/ >> ./log.txt 2>&1
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

chmod 755 /usr/local/etc/rc.d/wireguard.sh >> ./log.txt 2>&1

if [ -s "log.txt" ]
then
 echo -e "\n "
 echo -e "\nCheck file log.txt for any errors !"
 echo -e "\n "
else
 echo -e "\n ================================================"
 echo "---> Wireguard module installed succesfully <---"
 echo -e "\n ================================================"
fi
