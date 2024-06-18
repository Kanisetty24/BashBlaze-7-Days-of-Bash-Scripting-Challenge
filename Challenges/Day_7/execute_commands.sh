#!/bin/bash

# Define your VM's hostname or IP Address
client1="10.0.2.4"
client2="10.0.2.6"

# Function to execute commands on a remote machine via SSH
execute_remote_commands() {
    local user="$1"
    local host="$2"

    echo "Executing commands on $user@$host..."
    
    # Execute 'uptime' command
    echo "Uptime:"
    ssh "$user@$host" uptime
    if [ $? -ne 0 ]; then
        echo "Failed to execute 'uptime' on $user@$host"
    fi
    echo ""
    
    # Execute 'uname -a' command
    echo "System Information:"
    ssh "$user@$host" uname -a
    if [ $? -ne 0 ]; then
        echo "Failed to execute 'uname -a' on $user@$host"
    fi
    echo ""
    
    # Execute 'date' command
    echo "Current Date and Time:"
    ssh "$user@$host" date
    if [ $? -ne 0 ]; then
        echo "Failed to execute 'date' on $user@$host"
    fi
    echo ""
}

# Execute commands on client1 as user vardhan
execute_remote_commands "vardhan" "$client1"
echo ""

# Execute commands on client2 as user dhanush
execute_remote_commands "dhanush" "$client2"
