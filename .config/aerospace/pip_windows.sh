#!/usr/bin/env bash
export PATH="/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:$PATH"

# Redirect all output to a log file
exec > /tmp/pip_windows.log 2>&1
echo "=== Script started at $(date) ==="

# Ensure we have a valid workspace
ws=${1:-$AEROSPACE_FOCUSED_WORKSPACE}
if [[ -z "$ws" ]]; then
    echo "No workspace specified and AEROSPACE_FOCUSED_WORKSPACE is empty. Using workspace 1 as default."
    ws="1"
fi
echo "Target workspace: $ws"

# Get all windows and workspaces
echo "Running: aerospace list-windows --all"
all_wins=$(aerospace list-windows --all --format '%{window-id}|%{window-title}|%{workspace}')
if [[ -z "$all_wins" ]]; then
    echo "Error: Failed to get window list from aerospace"
    exit 1
fi

# Debug: Print all windows to see what we're working with
echo "All windows:"
echo "$all_wins"

# Match any Picture-in-Picture window using grep
echo "Searching for PIP windows"
pip_wins=$(printf '%s\n' "$all_wins" | grep -i 'picture')

# Debug: Print matched PIP windows
echo "Matched PIP windows:"
echo "$pip_wins"

# Check if we found any PIP windows
if [[ -z "$pip_wins" ]]; then
    echo "No Picture-in-Picture windows found"
    exit 0
fi

# Process each PIP window found
while IFS='|' read -r win_id win_title win_ws _; do
    [[ -z $win_id ]] && continue
    
    echo "Processing window: $win_id | $win_title | Workspace: '$win_ws'"
    
    # Handle empty workspace value
    if [[ -z "$win_ws" ]]; then
        echo "Window has no workspace assigned, treating as floating window"
        # For windows with no workspace, just make them floating on the target workspace
        echo "Moving window to workspace $ws"
        aerospace move-node-to-workspace --window-id "$win_id" "$ws"
        aerospace layout floating --window-id "$win_id"
        continue
    fi
    
    # Skip if already on target workspace
    [[ $ws == "$win_ws" ]] && {
        echo "Window already on target workspace, making floating"
        aerospace layout floating --window-id "$win_id"
        continue
    }

    # Move to workspace and make floating
    echo "Moving window from workspace $win_ws to workspace $ws"
    aerospace move-node-to-workspace --window-id "$win_id" "$ws"
    aerospace layout floating --window-id "$win_id"
done < <(printf '%s\n' "$pip_wins")

echo "=== Script finished at $(date) ==="
