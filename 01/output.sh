#!/bin/bash

# Check if the parameter is a number
is_number() {
  local number_pattern='^\s*[+-]?[0-9]+(\.[0-9]+)?\s*$'
  [[ "$1" =~ $number_pattern ]]
}