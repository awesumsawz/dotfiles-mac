#!/bin/bash

# Set up PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:$PATH"

# Get the workspace argument
WORKSPACE="$1"

# Update sketchybar
sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$WORKSPACE

# Run the PIP windows script
$HOME/.config/aerospace/pip_windows.sh "$WORKSPACE"