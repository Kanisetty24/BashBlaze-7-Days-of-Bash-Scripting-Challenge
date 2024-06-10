#!/bin/bash

# Function to create a backup
function create_backup {
    src_dir="$1"  # Source directory to be backed up
    tgt_dir="/Backup"  # Target directory where backups are stored
    current_timestamp=$(date "+%Y-%m-%d-%H-%M-%S")  # Get current timestamp
    final_file="/Backup/backup_$current_timestamp.tgz"  # Name the backup file with timestamp
    tar czf "$final_file" -C "$src_dir" .  # Create a compressed tar archive of the source directory
}

# Count the number of files in the /Backup directory
count=$(ls /Backup | wc -l)

# Check if there are more than 3 backups
if [ $count -ge 3 ]; then
    # Get the oldest backup filename
    filename=$(ls -ltr /Backup | head -n 2 | tail | awk '{print $9}' | tr -d '[:space:]')
    echo "The oldest backup filename is: $filename"
    # Remove the oldest backup
    rm -r "/Backup/$filename"
fi

echo "Starting the process of taking backup"
# Call the function to create a backup
create_backup "$1"
# Output confirmation message
echo "Backup is successfully created"
