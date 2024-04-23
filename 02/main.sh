#!/bin/bash

source $(dirname "$0")/output.sh

# Check if the number of parameters is correct
if [ $# -ne 0 ]; then
  echo "Error: Wrong number of command-line arguments. The script is run without parameters."
else
  get_research_data
  output_data
  # Prompt the user to save the output to a file
  read -p "Save the data to a file? (Y/N): " answer
  if [[ $answer =~ ^[Yy]$ ]]; then
    save_data
  fi
fi