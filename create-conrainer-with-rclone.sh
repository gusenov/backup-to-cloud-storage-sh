#!/bin/bash

# set -n  # Uncomment to check your syntax, without execution.
# set -x  # Uncomment to debug this shell script

# Usage:
#  ./create-conrainer-with-rclone.sh -n="files"
#  ./create-conrainer-with-rclone.sh --name="files"

container_name="files"

for i in "$@"; do
  case $i in
    -n=*|--name=*)
      container_name="${i#*=}"
      shift # past argument=value
      ;;
    *)
      exit 1
      ;;
  esac
done

lxc image list  # local
lxc image list ubuntu: | less  # remote

lxc init ubuntu:18.04 "$container_name"
lxc list

lxc exec "$container_name" -- apt-get update
lxc exec "$container_name" -- apt-get upgrade
lxc exec "$container_name" -- apt-get autoremove

lxc exec "$container_name" -- apt install rclone

# lxc stop "$container_name"
# lxc delete "$container_name"
