#!/bin/bash

start_tray() {
    echo "Starting Kanata..."
    ~/.config/kanata-tray/kanata-tray-macos & disown
    sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon' & disdown
    sudo ~/.config/kanata/kanata_macos_cmd_allowed_arm64 --cfg ~/.config/kanata/kanata.kbd & disdown
    echo "Kanata startup complete!"
}

stop_tray() {
    if pgrep -f "kanata-tray-macos" > /dev/null; then
        echo "Stopping Kanata Tray..."
        pkill -f "kanata-tray-macos"
        sleep 1
        echo "Kanata Tray stopped."
    else
        echo "No Kanata Tray process found."
    fi
    if pgrep -f "kanata_macos_cmd_allowed_arm64" > /dev/null; then
        echo "Existing Kanata process found, terminating..."
        sudo pkill -f "kanata_macos_cmd_allowed_arm64"
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
