### START-OF-ICON-MAP
function icon_map() {
  case "$1" in
  "Battle.net")
    icon_result=""
    ;;
  "Calculator" | "Calculette")
    icon_result=""
    ;;
  "Calendar" | "日历" | "Fantastical" | "Cron" | "Amie" | "Calendrier" | "Notion Calendar")
    icon_result="󰃭"
    ;;
  "Code" | "Code - Insiders" | "Cursor")
    icon_result="󰨞"
    ;;
  "Default")
    icon_result=""
    ;;
  "Discord" | "Discord Canary" | "Discord PTB")
    icon_result=""
    ;;
  "Docker" | "Docker Desktop")
    icon_result=""
    ;;
  "Figma")
    icon_result=""
    ;;
  "Finder" | "访达")
    icon_result="󰀶"
    ;;
  "Firefox" | "Firefox Developer Edition" | "Firefox Nightly" | "Firefox ESR")
    icon_result=""
    ;;
  "System Preferences" | "System Settings" | "系统设置" | "Réglages Système")
    icon_result=""
    ;;
  "GitHub Desktop")
    icon_result=""
    ;;
  "Chromium" | "Google Chrome" | "Google Chrome Canary")
    icon_result=""
    ;;
  "Ghostty")
    icon_result=""
    ;;
  "Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "Superhuman" | "Spark" | "邮件")
    icon_result=""
    ;;
  "Messages" | "信息" | "Nachrichten")
    icon_result=""
    ;;
  "Neovide" | "neovide" | "Neovim" | "neovim" | "nvim")
    icon_result=""
    ;;
  "ChatGPT")
    icon_result=":openai:"
    ;;
  "PhpStorm")
    icon_result=""
    ;;
  "Plex")
    icon_result="󰚺"
    ;;
  "Postman")
    icon_result=""
    ;;
  
  "Sequel Ace" | "Sequel Pro")
    icon_result="󰆼"
    ;;
  "Slack")
    icon_result="󰒱"
    ;;
  *)
    icon_result=""
    ;;
  esac
}
### END-OF-ICON-MAP

icon_map "$1"

echo "$icon_result"
