#!/usr/bin/env bash
export PATH="/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:$PATH"

ws=${1:-$AEROSPACE_FOCUSED_WORKSPACE}

# Get all windows and workspaces - use a more specific format to reduce data transfer
IFS=$'\n' read -r -d '' all_wins < <(aerospace list-windows --all --format '%{window-id}|%{window-title}|%{workspace}')

# Combine all PIP title patterns into a single regex for one-pass matching
pip_wins=$(printf '%s\n' "$all_wins" | rg -i 'picture.?in.?picture|picture.in.picture.*firefox')

# Process each PIP window found - more efficient loop
while IFS='|' read -r win_id win_title win_ws _; do
    [[ -z $win_id ]] && continue
    
    # Skip if already on target workspace
    [[ $ws == "$win_ws" ]] && {
        aerospace layout floating --window-id "$win_id"
        continue
    }

    # Move to workspace and make floating
    aerospace move-node-to-workspace --window-id "$win_id" "$ws"
    aerospace layout floating --window-id "$win_id"
done < <(printf '%s\n' "$pip_wins")
