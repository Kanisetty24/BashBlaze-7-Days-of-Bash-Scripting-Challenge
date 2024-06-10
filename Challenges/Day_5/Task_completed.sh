#!/bin/bash

# Getting the current timestamp
current_timestamp=$(date +"%d-%m-%Y-%H-%M")

# Redirecting the standard output to a log file with the current timestamp
exec > summaryreport-$current_timestamp.log

echo "Date of Analysis : $current_timestamp"

# Moving to the log directory or exiting if unsuccessful
cd "$1" || exit
echo ""
# Finding the most recent log file
log_file=$(ls -ltr | grep '\.log$' | tail -n 1 | awk '{print $9}')
echo "Filename: $log_file"
echo ""
# Counting the total lines proceed in the log file
total_lines=$(wc -l < "$log_file")
echo "Total lines processed in the log file: $total_lines"
echo ""
# Counting the total number of errors in the log file
count=$(grep -i error "$log_file" | wc -l)
echo "The total number of errors: $count"

echo ""

# Displaying the top 5 errors if there are more than 5 errors
if [ "$count" -gt 5 ]; then
    echo "Below are the top 5 errors which occurred frequently:"
    echo ""
    grep "ERROR" "$log_file" | sort | uniq -c | sort -nr | head -n 5
elif [ "$count" -gt 0 ]; then
    # Displaying all errors if there are any but less than 5
    echo "Errors found in the log file:"
    grep "ERROR" "$log_file"
fi
echo""
# Printing all lines containing "CRITICAL" in the log file
awk '/CRITICAL/ {print NR".",$0}' "$log_file"

# Setting up the archive directory path
archive_dir="/Backup/archived_logs"

# Creating the archive directory if it doesn't exist
mkdir -p "$archive_dir"

# Moving the processed log file to the archive directory
mv "$log_file" "$archive_dir/"
echo ""
# Providing a message indicating the log file has been archived
echo "Log file has been archived to: $archive_dir/$log_file"
