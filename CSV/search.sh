#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <wordlist_file> <filename>"
    exit 1
fi

wordlist_file="$1"
filename="$2"
log_file="log.txt"

# Check if the specified wordlist file exists
if [ ! -f "$wordlist_file" ]; then
    echo "Wordlist file '$wordlist_file' does not exist."
    exit 1
fi

# Check if the specified file exists
if [ ! -f "$filename" ]; then
    echo "File '$filename' does not exist."
    exit 1
fi

# Read the wordlist file line by line and search for each word in the file
while IFS= read -r word; do
    grep -n "$word" "$filename" | while read -r line; do
        line_number=$(echo "$line" | cut -d ':' -f 1)
        line_text=$(echo "$line" | cut -d ':' -f 2-)
        echo "Word: $word, Line $line_number: [$line_text]" >> "$log_file"
    done
done < "$wordlist_file"

echo "Search complete. Results logged in '$log_file'."
