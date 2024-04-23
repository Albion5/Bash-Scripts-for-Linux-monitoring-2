#!/bin/bash
source $(dirname "$0")/functions.sh
source $(dirname "$0")/arrays.sh
source $(dirname "$0")/config.conf
source $(dirname "$0")/default.conf


# Access the values from the configuration file
get_color_scheme() {
  bg_color1=${column1_background:-$default_column1_bg}
  fg_color1=${column1_font_color:-$default_column1_fg}
  bg_color2=${column2_background:-$default_column2_bg}
  fg_color2=${column2_font_color:-$default_column2_fg}
}

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

# Check if the args are between 1 and 6
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

# Check if any of the colour combinations are invalid
check_combinatios() {
  [ "$1" -ne "$2" ] && [ "$3" -ne "$4" ]
}

handle_config_errors() {
  local result=1 
  if ! check_args ${bg_color1} ${fg_color1} ${bg_color2} ${fg_color2} ; then
    echo "Error: wrong options. Only color options from 1 to 6 are available."
  elif ! check_combinatios  ${bg_color1} ${fg_color1} ${bg_color2} ${fg_color2} ; then
    echo "Error: Invalid colour combination. The font and background colours of one column must not match."
    echo "Try running the script again."
  else
    result=0
  fi
  return $result 
}

get_fg_code() {
  echo ${color_codes[$1]}
}

get_bg_code() {
  echo $(($(get_fg_code $1) + 10))
}

get_color_name() {
  echo ${color_names[$1]}
}

color_value() {
  echo -e "\e[${1};${2}m${3}\e[0m"
}

# Get codes and names of color scheme options
get_color_scheme_info() {
  bg_code1=$(get_bg_code ${bg_color1})
  fg_code1=$(get_fg_code ${fg_color1})
  bg_code2=$(get_bg_code ${bg_color2})
  fg_code2=$(get_fg_code ${fg_color2})
  color_name1=$(get_color_name ${bg_color1})
  color_name2=$(get_color_name ${fg_color1})
  color_name3=$(get_color_name ${bg_color2})
  color_name4=$(get_color_name ${fg_color2})
}

output_colored_data() {
  local var_array=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SEC" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")
  for var in "${var_array[@]}"
  do
    local name="${var}"
    local value="${!var}"
    local colored_name="$(color_value "$bg_code1" "$fg_code1" "$name")"
    local colored_value="$(color_value "$bg_code2" "$fg_code2" "$value")"
    echo "${colored_name} = ${colored_value}"
  done
}

display_color_scheme() {
  echo -e "\nColumn 1 background = ${column1_background:-default} ($color_name1)"
  echo "Column 1 font color = ${column1_font_color:-default} ($color_name2)"
  echo "Column 2 background = ${column2_background:-default} ($color_name3)"
  echo "Column 2 font color = ${column2_font_color:-default} ($color_name4)"
}