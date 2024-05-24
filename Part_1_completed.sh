#!/bin/bash

# Check if a process name is provided as an argument
if [ -z "$1" ]; then
    echo "Error: Process name not provided."
    exit 1
fi

# Check if the process is running
input=$(sudo systemctl status "$1" | grep -i running)

# If the process is not running, attempt to restart it
if [ -z "$input" ]; then
    count=0
    echo "We are attempting to restart the process $1 ..."
    while [ $count -l 3 ]; do
        #sudo systemctl restart "$1"
        sleep 5 # Wait for a few seconds before checking again
        input=$(sudo systemctl status "$1" | grep -i running)

        # If the process is running after restart, exit loop
        if [ -n "$input" ]; then
            echo "The $1 process has been successfully restarted"
            exit 0
        fi
        ((count++)) # Increment the retry count
    done

    # If unable to restart after 3 attempts, display error message and exit
    echo "Failed to restart the $1 process after 3 attempts."
    exit 1
else
    # If the process is already running, display message
    echo "The $1 process is already running"
fi
