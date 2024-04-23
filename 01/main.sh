#!/bin/bash

source $(dirname "$0")/output.sh
# Check if the parameter is provided
# `$#` is a special variable that holds the number of command-line arguments passed to the script or function

if [ $# -eq 0 ]; then
  echo "Error: Not enough arguments."
elif [ $# -gt 1 ]; then
  echo "Error: Too many arguments."
elif is_number "$1"; then
  arg=$(echo "$1" | sed 's/ //g')
  echo "Invalid input: $arg is a number."
else
  echo "$1"
fi