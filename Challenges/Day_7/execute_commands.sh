#!/bin/bash

# Define your VM's hostname or IP Address
client1="10.0.2.4"
client2="10.0.2.6"

# Function to execute commands on a remote machine via SSH
execute_remote_commands() {
    local user="$1"
    local host="$2"

    echo "Executing commands on $user@$host..."
    echo "Uptime:"
    ssh "$user@$host" uptime
    echo ""
    echo "System Information:"
    ssh "$user@$host" uname -a
    echo ""
    echo "Current Date and Time:"
    ssh "$user@$host" date
    echo ""
}

# Execute commands on client1 as user vardhan
execute_remote_commands "vardhan" "$client1"
echo ""

# Execute commands on client2 as user dhanush
execute_remote_commands "dhanush" "$client2"
