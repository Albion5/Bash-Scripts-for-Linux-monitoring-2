#!/bin/bash
source $(dirname "$0")/functions.sh

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

output_data() {
  local values=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SEC" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")
  for value in "${values[@]}"
  do
    echo "${value} = ${!value}"
  done
}

save_data() {
  # Format the file name based on the current date and time
  filename=$(date +"%d_%m_%y_%H_%M_%S.status")
  # Write the output to a file
  output_data > $filename
  echo "Data has been saved to the file: $filename"

}
