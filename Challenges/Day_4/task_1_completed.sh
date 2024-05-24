#!/bin/bash

# Check if a process name is provided as an argument
if [ -z "$1" ]; then
    echo "Error: Process name not provided."
    exit 1
fi

# Check if the process is running
status=$(sudo systemctl is-active "$1")

# If the process is not running, attempt to restart it
if [ "$status" != "active" ]; then
    count=0
    while [ $count -lt 3 ]; do
        echo "Attempting to restart the process $1 ..."
        sudo systemctl restart "$1"
        sleep 5 # Wait for a few seconds before checking again
        status=$(sudo systemctl is-active "$1")

        # If the process is running after restart, exit loop
        if [ "$status" == "active" ]; then
            echo "The $1 process has been successfully restarted."
            exit 0
        fi
        ((count++)) # Increment the retry count
    done

    # If unable to restart after 3 attempts, display error message and exit
    echo "Maximum restart attempts reached. Please check the process manually."
    exit 1
else
    # If the process is already running, display message
    echo "The $1 process is already running."
fi

