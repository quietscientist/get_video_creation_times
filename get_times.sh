#!/bin/bash

# Usage: ./get_times.sh <input_folder> <output_csv_file>

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_folder> <output_csv_file>"
  exit 1
fi

input_folder="$1"
output_csv="$2"

# Initialize the CSV file with a header
echo "Filename,CreationTime" > "$output_csv"

# Loop through all files in the folder
for file in "$input_folder"/*; do

  creation_time=$(/opt/homebrew/bin/ffprobe "$file" 2>&1 | grep -i creation_time | head -n 1 | awk -F': ' '{print $2}')
  echo "$(basename "$file"),$creation_time" >> "$output_csv"

done

echo "Processing complete. Results saved to $output_csv"
