#!/bin/bash

source $(dirname "$0")/output.sh

# Check if the number of parameters is correct
if [ $# -ne 4 ]; then
  echo "Error: Incorrect number of parameters."
  echo "Usage: $0 <color1> <color2> <color3> <color4>"
  echo "       color1 - Background color for value names (1-6)"
  echo "       color2 - Font color for value names (1-6)"
  echo "       color3 - Background color for values (1-6)"
  echo "       color4 - Font color for values (1-6)"
# Check if the args are between 1 and 6
elif ! check_args "$1" "$2" "$3" "$4"; then
  echo "Error: Wrong options. Color options must be integers from 1 to 6."
# Check if any of the colour combinations are invalid
elif ! check_combinatios "$1" "$2" "$3" "$4"; then
  echo "Error: Invalid colour combination. The font and background colours of one column must not match."
  echo "Try running the script again."
# Display data
else
  get_research_data
  get_color_scheme "$1" "$2" "$3" "$4"
  output_colored_data 
fi
