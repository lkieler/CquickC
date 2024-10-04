#!/bin/bash

###########################################################################
## c-quickcompiler                                                       ##
## Copyright (C) 2024                                                    ##
##                                                                       ##
## This program is free software: you can redistribute it and/or modify  ##
## it under the terms of the GNU General Public License as published by  ##
## the Free Software Foundation, either version 3 of the License, or     ##
## (at your option) any later version.                                   ##
##                                                                       ##
## This program is distributed in the hope that it will be useful,       ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         ##
## GNU General Public License for more details.                          ##
##                                                                       ##
## You should have received a copy of the GNU General Public License     ##
## along with this program.  If not, see <http://www.gnu.org/licenses/>. ##
###########################################################################

# Get the terminal width
terminal_width=$(tput cols)

# Function to print a line with the specified character filling the terminal width
print_line() {
    local char="$1"
    printf "%${terminal_width}s\n" | tr ' ' "$char"
}

# Find all .c files in the current directory, sorted by modification time
c_files=($(ls -t *.c 2>/dev/null))

# Check how many .c files exist
if [ ${#c_files[@]} -eq 0 ]; then
    # Print current working directory
    echo "Error: No .c files found in this directory. ($(pwd))"
    exit 1
elif [ ${#c_files[@]} -eq 1 ]; then
    # Only one file found, no need to prompt
    c_file="${c_files[0]}"
else
    # Multiple .c files found, display options
    echo
    print_line "="
    echo " Multiple files found in directory: $(pwd)"
    print_line "="
    for i in "${!c_files[@]}"; do
        echo "  $((i+1))) ${c_files[$i]}"
    done
    print_line "="
    echo

    # Prompt user to make a choice, default to 1 if Enter is pressed
    read -p "Enter the number [Default=1]: " choice

    # Set default choice to 1 if Enter is pressed without input
    choice=${choice:-1}

    # Check if the input is valid
    if [[ "$choice" -gt 0 && "$choice" -le ${#c_files[@]} ]]; then
        c_file="${c_files[$((choice-1))]}"
    else
        echo "Invalid choice. Exiting."
        exit 1
    fi
fi

# Extract the filename without extension
filename=$(basename "$c_file" .c)

# Compile the chosen .c file
gcc "$c_file" -o "$filename"

# Check if compilation succeeded
if [ $? -eq 0 ]; then
    echo
    echo "Compilation succeeded. Running the program:"
    print_line "-"
    ./"$filename"
    print_line "-"
else
    echo "Compilation failed."
fi

