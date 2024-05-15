#!/bin/bash

input_file="xsslink"
if [ ! -f "$input_file" ]; then
    echo "Input file $input_file not found."
    exit 1
fi
while IFS= read -r domain; do
    echo "Testing domain: $domain"
    python3 ~/tools/XSStrike/xsstrike.py -u "$domain" 
done < "$input_file"