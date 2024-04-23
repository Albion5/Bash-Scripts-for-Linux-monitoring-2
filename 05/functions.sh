#!/bin/bash

get_folders_list() {
  find "$1" -mindepth 1 -type d
}

get_files_list() {
  find "$1" -type f
}

get_links_list() {
  find "$1" -type l
}

get_total() {
  echo "$1" | wc -w
}

get_folders_top() {

  for folder in $1; do
    du -sh "$folder"
  done | sort -rh | awk -v num="$2" '
    NR==1, NR==num {
      printf "%d - %s, %s\n", NR, $2, $1;
    }
  '
}

get_files_top() {
  for file in $1; do
    du -sh "$file"
  done | sort -rh | awk -v num="$2" '
    NR==1, NR==num {
      file_name = $2;
      gsub(".*/", "", file_name);  # Remove everything before the last "/"
      len = split(file_name, substrs, ".");
      type = (len > 1) ? substrs[len] : "empty";
      printf "%d - %s, %s, %s\n", NR, $2, $1, type;
    }
  '
}

get_executable_top() {
  for file in $1; do
    du -sh "$file"
  done | sort -rh | awk -v num="$2" '
    NR==1, NR==num {
      cmd = "md5sum " $2;
      cmd | getline hash_output;
      close(cmd);
      split(hash_output, columns, " ");
      printf "%d - %s, %s, %s\n", NR, $2, $1, columns[1];
    }
  '
}

get_files_by_extension() {
  echo "$1"  | grep -E "$2"
}

get_executable_files() {
  local files_list=$1
  local executable_files=""

  while IFS= read -r file; do
    if [[ -x "$file" ]]; then
      executable_files+="$file\n"
    fi
  done <<< "$files_list"

  echo -e "$executable_files"
}