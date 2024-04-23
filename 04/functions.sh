#!/bin/bash
get_hostname() { 
  hostname
}

get_timezone() {
  local timezone=$(cat /etc/timezone)
  local utc=$(date -u +'%Z')
  local local_time=$(date +'%Z')
  echo "$timezone $utc $local_time"
}

get_user() {
  whoami
}

get_os() {
  echo "$(uname -o) $(lsb_release -ds)"
}

get_date() {
  date +"%d %b %Y %T"
}

get_uptime() {
  uptime -p | sed 's/up //'
}

get_uptime_sec() {
  cat /proc/uptime | awk '{print $1}'
}

get_ip() {
  hostname -I | awk '{print $1}'
}

get_mask() {
  ifconfig | grep $(get_ip) | awk '{print $4}'
}

get_gateway() {
  ip r | awk '/default/ {print $3; exit}'
}

get_memory_usage() {
  local field_num=2
  case "$1" in
    "total") field_num=2 ;;
    "used") field_num=3 ;;
    "free") field_num=4 ;;
  esac
  local value=$(free --mega | awk -v column="$field_num" '/Mem/ { printf "%.3f", $column/1000 }')
  echo "$value GB"

}

get_root_partion() {
  local field_num=2
  case "$1" in
    "total") field_num=2 ;;
    "used") field_num=3 ;;
    "free") field_num=4 ;;
  esac
  local value=$(df / --block-size=KB | awk -v column="$field_num" '/dev/ {printf "%.2f", $column/1000}')
  echo "$value MB"
}