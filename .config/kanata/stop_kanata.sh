#!/bin/bash

echo "Stopping Kanata..."

# Kill Kanata process
if pgrep -f "kanata_macos_cmd_allowed_arm64" > /dev/null; then
    sudo pkill -f "kanata_macos_cmd_allowed_arm64"
    echo "Kanata process terminated"
else
    echo "No Kanata process found"
fi

# Kill Karabiner daemon
if pgrep -f "Karabiner-VirtualHIDDevice-Daemon" > /dev/null; then
    sudo pkill -f "Karabiner-VirtualHIDDevice-Daemon"
    echo "Karabiner daemon terminated"
else
    echo "No Karabiner daemon found"
fi

echo "Kanata shutdown complete!" 