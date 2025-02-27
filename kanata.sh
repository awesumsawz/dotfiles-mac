#!/bin/bash

start_tray() {
    echo "Starting Kanata..."
    sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon' & disown
    sudo kanata --quiet --nodelay --cfg ~/.config/kanata/kanata.kbd & disown
    sleep 10 
    echo "Kanata startup complete!"
}

stop_tray() {
    if pgrep -f "kanata" > /dev/null; then
        echo "Existing Kanata process found, terminating..."
        sudo pkill -f "kanata"
        sleep 1
    else 
      echo "No Kanata process found."
    fi

    if pgrep -f "Karabiner-VirtualHIDDevice-Daemon" > /dev/null; then
        echo "Existing Karabiner daemon found, terminating..."
        sudo pkill -f "Karabiner-VirtualHIDDevice-Daemon"
        sleep 1
    else
        echo "No Karabiner daemon found."
    fi
}

case "$1" in
    start)
        stop_tray
        start_tray
        ;;
    stop)
        stop_tray
        ;;
    restart)
        stop_tray
        start_tray
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0 
