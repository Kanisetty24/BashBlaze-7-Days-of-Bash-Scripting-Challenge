#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then
  echo "Usage: ./recursive_search.sh <directory> <target_file>"
  exit 1
fi

search_directory="$1"
target_file="$2"

# Check if the directory exists
if [ ! -d "$search_directory" ]; then
  echo "Directory not found: $search_directory"
  exit 1
fi

# Use find command to search for the target file
path=$(find "$search_directory" -name "$target_file" -print -quit)

# Check if the target file is found
if [ -n "$path" ]; then
  echo "The absolute path of the file '$target_file' is: $path"
  exit 0
else
  echo "File not found: $target_file"
  exit 1
fi
