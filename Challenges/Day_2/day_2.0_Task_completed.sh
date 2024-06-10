#!/bin/bash

echo "Welcome to the Interactive File and Directory Explorer!"
echo

echo "Files and Directories in the Current Path:"
ls -l --block-size=MB | awk 'NR>1 {print "-", $9, "(", $5, ")"}'
echo


while true; do
    read -p "Enter a line of text (Press Enter without text to exit): " input
    if [ -z "$input" ]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi
    echo "Character Count: $(echo "$input" | wc -m)"
    echo
done
