#!/bin/bash

# This script demonstrates a solution to the race condition bug using file locking.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file with locking
write_to_file() {
  local file=$1
  local message=$2
  flock -n 20000 "$file" || exit 1
  echo "$message" >> "$file"
  flock -u 20000 "$file"
}

# Start two processes concurrently
process1() {
  write_to_file file1.txt "Process 1 writing to file1.txt"
  sleep 1
  write_to_file file2.txt "Process 1 writing to file2.txt"
}

process2() {
  write_to_file file2.txt "Process 2 writing to file2.txt"
  sleep 1
  write_to_file file1.txt "Process 2 writing to file1.txt"
}

# Run the processes in the background
process1 & process2 &

# Wait for the processes to finish
wait

# Print the content of both files
cat file1.txt
cat file2.txt