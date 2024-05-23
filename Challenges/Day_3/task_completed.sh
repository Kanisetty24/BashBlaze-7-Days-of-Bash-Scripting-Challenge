#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --create     Create a new user account."
    echo "  -d, --delete     Delete an existing user account."
    echo "  -r, --reset      Reset password for an existing user account."
    echo "  -l, --list       List all user accounts on the system."
    echo "  -h, --help       Display this help and exit."
}

# Function to create a new user account
create_user() {
    echo "Please enter username:"
    read username

    # Check if the user already exists
    input=$(grep "^$username:" /etc/passwd)

    if [ -z "$input" ]; then
        # Create the user with the specified username
        sudo useradd "$username"
        echo "Please enter password:"
        read -s password
        # Set the user's password
        echo "$username:$password" | sudo chpasswd

        echo "The user account is created successfully"
    else
        echo "There is already an account with this username"
    fi
}

# Function to delete an existing user account
delete_user() {
    echo "Please enter the username to remove:"
    read username

    # Check if the user exists
    input=$(grep "^$username:" /etc/passwd)
    if [ -n "$input" ]; then
        sudo userdel -r "$username"
        echo "The user account $username has been removed successfully"
    else
        echo "No account exists with the username $username"
    fi
}

# Function to reset password for an existing user account
reset_password() {
    echo "Please enter username:"
    read username

    # Check if the user already exists
    input=$(grep "^$username:" /etc/passwd)

    if [ -n "$input" ]; then
        echo "Please enter the new password:"
        read -s password

        # Set the user's password
        echo "$username:$password" | sudo chpasswd

        if [ $? -eq 0 ]; then
            echo "The user account password is reset successfully"
        else
            echo "Failed to reset the user account password"
        fi
    else
        echo "No account exists with the username $username"
    fi
}

# Function to list all user accounts on the system
list_users() {
    echo "User accounts on the system:"
    sudo awk -F: '{print "-", $1, "(UID - "$3")"}' /etc/passwd
}

# Check for options
case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        display_usage
        ;;
    *)
        echo "Invalid option: $1"
        display_usage
        ;;
esac
