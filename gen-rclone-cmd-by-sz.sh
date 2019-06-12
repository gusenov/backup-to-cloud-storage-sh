#!/bin/bash

# set -n  # Uncomment to check your syntax, without execution.
# set -x  # Uncomment to debug this shell script

# Usage:
#  ./gen-rclone-cmd-by-sz.sh -d="~/path/to/source/folder" -r="your_remote_name" -l="./logs" > "./logs/cmd.log"

for i in "$@"; do
  case $i in
    -d=*|--dir=*)
      dir_path="${i#*=}"
      eval dir_path="$dir_path"
      shift # past argument=value
      ;;
    -r=*|--remote_name=*)
      remote_name="${i#*=}"
      shift # past argument=value
      ;;
    -l=*|--log=*)
      log_path="${i#*=}"
      eval log_path="$log_path"
      shift # past argument=value
      ;;
    *)
      exit 1
      ;;
  esac
done

parent_dir_path="$(dirname "$dir_path")"

du -sh "$dir_path"/* | sort -h | while read line; do
  size=$(echo "$line" | awk '{print $1}')
  path=$(echo "$line" | awk '{print $2}')
  relative_path="${path#$parent_dir_path/}"

  echo "# $size"
  echo "./run-rclone.sh -s=\"$path\" -d=\"$remote_name:$relative_path\" -l=\"$log_path\""
  echo
done
