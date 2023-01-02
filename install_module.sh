#!/bin/sh
cp ./wireguard.ko /lib/modules/
chmod 644 /lib/modules/wireguard.ko

# register the module
insmod /lib/modules/wireguard.ko

#autorun at next restart
tee /usr/local/etc/rc.d/wireguard.sh <<EOF
    #!/bin/bash
    MODULES_UNLOAD="wireguard.ko"
    start_modules(){
        echo "--- Load module ---"
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
EOF

chmod 644 /usr/local/etc/rc.d/wireguard.sh
