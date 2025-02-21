#!/bin/bash

echo "Starting Kanata..."

# Kill any existing instances
if pgrep -f "kanata_macos_cmd_allowed_arm64" > /dev/null; then
    echo "Existing Kanata process found, terminating..."
    sudo pkill -f "kanata_macos_cmd_allowed_arm64"
    sleep 1
fi

if pgrep -f "Karabiner-VirtualHIDDevice-Daemon" > /dev/null; then
    echo "Existing Karabiner daemon found, terminating..."
    sudo pkill -f "Karabiner-VirtualHIDDevice-Daemon"
    sleep 1
fi

# Start the Karabiner daemon
echo "Starting Karabiner VirtualHIDDevice Daemon..."
sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon' &
daemon_pid=$!
disown $daemon_pid

# Wait a moment for the daemon to initialize
sleep 2

# Start Kanata
echo "Starting Kanata..."
sudo ~/.config/kanata/kanata_macos_cmd_allowed_arm64 --cfg ~/.config/kanata/kanata.kbd &
kanata_pid=$!
disown $kanata_pid

echo "Kanata startup complete!" 