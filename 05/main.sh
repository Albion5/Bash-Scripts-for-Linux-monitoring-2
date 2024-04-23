#!/bin/bash
source $(dirname "$0")/output.sh

if [ $# -ne 1 ] ; then
  echo "Error: Wrong number of command-line arguments. The script is run with a single parameter."
  echo "Usage: $0 <directory>"
elif [[ ! "$1" =~ /$ ]]; then
  echo "Error: Wrong parameter format. The parameter must end with '/'"
elif [ ! -d $1 ]; then
  echo "Error: Wrong parameter format. The parameter should be a directory."
else
    TIMEFORMAT="Script execution time (in seconds) = %R"
    time {
      get_research_data "$1"
      output_data
   }
fi