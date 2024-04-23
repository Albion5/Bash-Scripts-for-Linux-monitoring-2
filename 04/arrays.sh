#!/bin/bash

# Associative array to map color codes to color names
declare -A color_names=(
  [1]="white"
  [2]="red"
  [3]="green"
  [4]="blue"
  [5]="purple"
  [6]="black"
)

# An associative array with color codes matching arg options
declare -A color_codes=(
  [1]=37 # white
  [2]=31 # red
  [3]=32 # green
  [4]=34 # blue
  [5]=35 # purple
  [6]=30 # black
)