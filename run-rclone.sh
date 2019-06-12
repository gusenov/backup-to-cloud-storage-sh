#!/bin/bash

# set -n  # Uncomment to check your syntax, without execution.
# set -x  # Uncomment to debug this shell script

# Usage:
#  $ ./run-rclone.sh -s="~/path/to/src" -d="your_remote_name:path/to/dest" -l="./logs"

log_path="./"

for i in "$@"; do
  case $i in
    -s=*|--source=*)
      source_path="${i#*=}"
      shift # past argument=value
      ;;
    -d=*|--destination=*)
      destination_path="${i#*=}"
      shift # past argument=value
      ;;
    -l=*|--log=*)
      log_path="${i#*=}"
      shift # past argument=value
      ;;
    *)
      exit 1
      ;;
  esac
done

timestamp="$(date +"%Y%m%d_%H%M%S")"
log_file_name="rclone-$timestamp.log"
log_file_path="$log_path/$log_file_name"

echo "$ pwd" >> "$log_file_path"
echo "$(pwd)" >> "$log_file_path"
echo >> "$log_file_path"

echo "$ rclone sync "$source_path" "$destination_path"" >> "$log_file_path"
rclone sync "$source_path" "$destination_path" >> "$log_file_path"

# Options:
# --copy-links
# --config ~/.config/rclone/rclone.conf
# --progress
