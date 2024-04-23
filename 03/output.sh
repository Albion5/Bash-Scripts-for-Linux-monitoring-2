#!/bin/bash
source $(dirname "$0")/functions.sh
source $(dirname "$0")/arrays.sh

# Get the research data
get_research_data() {
  HOSTNAME=$(get_hostname)
  TIMEZONE=$(get_timezone)
  USER=$(get_user)
  OS="$(get_os)"
  DATE=$(get_date)
  UPTIME=$(get_uptime)
  UPTIME_SEC=$(get_uptime_sec)
  IP=$(get_ip)
  MASK=$(get_mask)
  GATEWAY=$(get_gateway)
  RAM_TOTAL=$(get_memory_usage "total")
  RAM_USED=$(get_memory_usage "used")
  RAM_FREE=$(get_memory_usage "free")
  SPACE_ROOT=$(get_root_partion "total")
  SPACE_ROOT_USED=$(get_root_partion "used")
  SPACE_ROOT_FREE=$(get_root_partion "free")
}

color_value() {
  echo -e "\e[${1};${2}m${3}\e[0m"
}

get_fg_code() {
  echo ${colors[$1]}
}

get_bg_code() {
  echo $(($(get_fg_code $1) + 10))
}

check_args() {
  local args=("$@")
  local pattern='^[1-6]$'
  local result=0 
  for arg in "${args[@]}"
  do
    if [[ ! $arg =~ $pattern ]]; then
      result=1
    fi
  done
  return $result 
}

check_combinatios() {
  [ "$1" -ne "$2" ] && [ "$3" -ne "$4" ]
}

# Get codes of color scheme options
get_color_scheme() {
  bg_name=$(get_bg_code $1)
  fg_name=$(get_fg_code $2)
  bg_value=$(get_bg_code $3)
  fg_value=$(get_fg_code $4)
}

output_colored_data() {
  local var_array=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SEC" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")
  for var in "${var_array[@]}"
  do
    local name="${var}"
    local value="${!var}"
    local colored_name="$(color_value "$bg_name" "$fg_name" "$name")"
    local colored_value="$(color_value "$bg_value" "$fg_value" "$value")"
    echo "${colored_name} = ${colored_value}"
  done
}