# Authored by claude, Hovis supervising
#
# groom_history - Interactive zsh history cleanup using fzf
#
# DESCRIPTION:
#   Presents a searchable, multi-select interface to remove unwanted commands
#   from your zsh history file. Uses fzf for fuzzy finding and allows selecting
#   multiple entries to purge in one session.
#
# REQUIREMENTS:
#   - fzf must be installed and available in PATH
#   - $HISTFILE environment variable must be set (standard in zsh)
#
# EXPECTED ZSH OPTIONS:
#   This function works with any zsh history configuration, but is particularly
#   useful when using:
#     - sharehistory: Shares history immediately between all sessions
#     - histexpiredupsfirst: Removes duplicates first when history fills
#     - histfindnodups: Doesn't show duplicates when searching history
#
# USAGE:
#   Source this file in your .zshrc:
#     source ~/bin/groom_history_function.zsh
#
#   Then run:
#     groom_history
#
#   In fzf:
#     - Type to fuzzy search commands
#     - TAB to select/deselect multiple entries
#     - ENTER to confirm and purge selected entries
#     - ESC or Ctrl-C to cancel
#
# HOW IT WORKS:
#   1. Loads all history entries and deduplicates them
#   2. Presents them in fzf with multi-select enabled
#   3. Removes selected entries from $HISTFILE
#   4. Reloads history in current shell session
#
function groom_history() {
  local selected

  # Load all history, reverse for most-recent-first, deduplicate, present in fzf
  # fc -l 1: List all history from entry 1 to present
  # tail -r: Reverse so most recent entries appear first (macOS)
  # awk #1: Strip the line numbers from fc output
  # awk #2: Deduplicate while preserving most-recent-first order
  # fzf --multi: Enable multi-select mode (TAB to select)
  selected=$(fc -l 1 | tail -r | awk '{$1=""; print substr($0,2)}' | awk '!seen[$0]++' | fzf --multi --height=40% --reverse --prompt="Select commands to purge (TAB to select multiple): ")

  # Only proceed if user selected something (didn't cancel with ESC)
  if [[ -n "$selected" ]]; then
    # Create working copy of history file to avoid corruption if interrupted
    cp "$HISTFILE" "${HISTFILE}.tmp"

    # Process each selected line
    # IFS= read -r: Read without word splitting or backslash interpretation
    # <<< "$selected": Here-string to iterate over each line of selected commands
    while IFS= read -r line; do
      # Filter out lines matching this command from the history file
      # Handle both plain format (command) and extended format (: timestamp:elapsed;command)
      # Also handle escaped colons: commands like ":term" are stored as "\:term"
      while IFS= read -r hist_line; do
        # Extract command from history line (strip timestamp prefix if present)
        local cmd="$hist_line"
        # Check if line starts with ": " (extended format)
        if [[ "${hist_line:0:2}" == ": " ]]; then
          # Find the second colon and semicolon, extract everything after the semicolon
          # Format is: ": timestamp:elapsed;command"
          cmd="${hist_line#*;}"
        fi

        # Unescape the command if it starts with backslash-colon
        if [[ "${cmd:0:2}" == '\:' ]]; then
          cmd=":${cmd:2}"
        fi

        # Keep line if command doesn't match
        [[ "$cmd" != "$line" ]] && echo "$hist_line"
      done < "${HISTFILE}.tmp" > "${HISTFILE}.tmp2"
      mv -f "${HISTFILE}.tmp2" "${HISTFILE}.tmp"
      echo "Removed: $line"
    done <<< "$selected"

    # Replace original history file with cleaned version
    mv -f "${HISTFILE}.tmp" "$HISTFILE"

    # Reload history in current shell session
    # fc -P: Pop/save current history stack (writes current session to file)
    # fc -p: Push/load fresh history from file (replaces in-memory history)
    # This ensures removed entries disappear immediately from current shell
    fc -P
    fc -p "$HISTFILE"
  fi
}                                                                                                                                    
