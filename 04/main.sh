#!/bin/bash


source $(dirname "$0")/output.sh


# Check if the number of parameters is correct
if [ $# -ne 0 ]; then
  echo "Error: Wrong number of command-line arguments. The script is run without parameters."
  echo "The parameters are set in the configuration file \"config.conf\"."
else
  get_color_scheme
  if handle_config_errors; then
      get_research_data
      get_color_scheme_info
      output_colored_data
      display_color_scheme
  fi
fi