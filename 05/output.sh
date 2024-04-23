#!/bin/bash
source $(dirname "$0")/functions.sh

# Get the research data (about the directory specified in the parameter)
get_research_data() {
  # Lists of data by type
  folders_list=$(get_folders_list "$1")
  files_list=$(get_files_list "$1")
  links_list=$(get_links_list "$1")

  # Lists of files by extension
  files_conf=$(get_files_by_extension "$files_list" ".conf$")
  files_txt=$(get_files_by_extension "$files_list" ".txt$")
  files_exe=$(get_executable_files "$files_list")
  files_log=$(get_files_by_extension "$files_list" ".log$")
  files_arch=$(get_files_by_extension "$files_list" ".zip$|.rar$|.tar$|.bz2$|.gz$|.7z$|.xz$")

  # Total count
  folders_total=$(get_total "$folders_list")
  files_total=$(get_total "$files_list")

  files_conf_total=$(get_total "$files_conf")
  files_txt_total=$(get_total "$files_txt")
  files_exe_total=$(get_total "$files_exe")
  files_log_total=$(get_total "$files_log")
  files_arch_total=$(get_total "$files_arch")
  links_total="$(get_total "$links_list")"

  # Lists of the largests
  folders_largest_5=$(get_folders_top "$folders_list" 5)
  files_largest_10=$(get_files_top "$files_list" 10)
  files_exe_largest_10=$(get_executable_top "$files_exe" 10)

}


output_data() {
  echo "Total number of folders (including all nested ones) = $folders_total"
  echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
  echo "$folders_largest_5"
  echo "Total number of files = $files_total"
  echo "Number of:"
  echo "Configuration files (with the .conf extension) = $files_conf_total"
  echo "Text files = $files_txt_total"
  echo "Executable files = $files_exe_total"
  echo "Log files (with the extension .log) = $files_log_total"
  echo "Archive files = $files_arch_total"
  echo "Symbolic links = $links_total"
  echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
  echo "$files_largest_10" 
  echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
  echo "$files_exe_largest_10"
}