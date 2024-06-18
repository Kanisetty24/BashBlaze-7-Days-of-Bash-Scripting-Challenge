#!/bin/bash

# Define variables for source and destinations
source_file="/home/mkanisetty/scripts/important_information"

# Destination 1
destination1_user="dhanush"
destination1_ip="10.0.2.6"
destination1_dir="/home/dhanush"

# Destination 2
destination2_user="vardhan"
destination2_ip="10.0.2.4"
destination2_dir="/home/vardhan"

# Function to perform SCP transfer
perform_scp_transfer() {
    local user="$1"
    local ip="$2"
    local dir="$3"

    echo "Transferring file to $user@$ip:$dir..."
    scp "$source_file" "$user@$ip:$dir"

    # Check transfer status
    if [ $? -eq 0 ]; then
        echo "File transferred successfully to $user@$ip."
    else
        echo "Error: Failed to transfer file to $user@$ip."
    fi
}

# Perform SCP transfer to Destination 1
perform_scp_transfer "$destination1_user" "$destination1_ip" "$destination1_dir"

# Perform SCP transfer to Destination 2
perform_scp_transfer "$destination2_user" "$destination2_ip" "$destination2_dir"
