#!/bin/bash

# Function to display the main menu
function show_main_menu {
    echo "---- Monitoring Metrics Script ----"
    echo ""
    echo "1. View System Metrics"
    echo "2. Monitor a Specific Service"
    echo "3. Exit"
    echo ""
}

# Function to display current system metrics (CPU, memory, and disk usage)
function view_system_metrics {
    echo "---- System Metrics ----"
    # Calculate CPU usage by subtracting idle percentage from 100%
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
    # Calculate memory usage as a percentage of total memory
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0"%"}')
    # Get the disk usage of the root file system
    disk_usage=$(df -h / | awk 'NR==2 {print $5}')
    # Display the metrics
    echo "CPU Usage: $cpu_usage   Mem Usage: $mem_usage   Disk Space: $disk_usage"
    echo ""
}

# Function to monitor a specific service
function monitor_specific_service {
    echo "---- Monitor a Specific Service ----"
    # Prompt the user to enter the name of the service to monitor
    read -p "Enter the name of the service to monitor: " service_name
    # Check if the specified service is active
    service_status=$(sudo systemctl is-active $service_name)
    if [ "$service_status" == "active" ]; then
        # If the service is running, display a message
        echo "$service_name is running."
    else
        # If the service is not running, display a message
        echo "$service_name is not running."
        # Prompt the user to decide if they want to start the service
        read -p "Do you want to start $service_name? (Y/N): " start_service
        # If the user chooses "Y" or "y", attempt to start the service
        if [[ "$start_service" == "Y" || "$start_service" == "y" ]]; then
            sudo systemctl start $service_name
            # Check if the service started successfully
            service_status=$(sudo systemctl is-active $service_name)
            if [ "$service_status" == "active" ]; then
                echo "$service_name has been started."
            else
                echo "Failed to start $service_name. Please check the service name and try again."
            fi
        fi
    fi
    echo ""
    echo "Press Enter to continue..."
    # Wait for user input to continue
    read
}

# Infinite loop to keep showing the main menu until the user chooses to exit
while true; do
    show_main_menu
    # Prompt the user to choose an option from the main menu
    read -p "Choose an option (1, 2, or 3): " option
    # Handle the user's choice using a case statement
    case $option in
        1)
            # If the user chooses 1, call the function to view system metrics in a loop
            while true; do
                view_system_metrics
                echo "Press Enter to refresh the metrics or type 'q' to return to the main menu..."
                read input
                if [ "$input" == "q" ]; then
                    break
                fi
                # Sleep for a specified interval before displaying metrics again
                sleep 5 # Change this value to the desired interval in seconds
            done
            ;;
        2)
            # If the user chooses 2, call the function to monitor a specific service
            monitor_specific_service
            ;;
        3)
            # If the user chooses 3, exit the script
            echo "Exiting..."
            exit 0
            ;;
        *)
            # If the user enters an invalid option, display an error message
            echo "Error: Invalid option. Please choose a valid option (1, 2, or 3)."
            echo ""
            ;;
    esac
done
