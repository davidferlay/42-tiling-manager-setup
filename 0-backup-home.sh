#!/bin/bash

# Define the home directory to back up
home_dir="$HOME"

# Define the destination directory (inside user's home)
dest_dir="$HOME"

# Create an archive filename based on hostname and the current day
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$dest_dir/${hostname}_home_backup_$day.tgz"

# Print start status message
echo "Backing up $home_dir to $archive_file"
date
echo

# Create the backup archive excluding the archive file itself
tar czpf "$archive_file" -C "$home_dir" --exclude="$(basename "$archive_file")" .

# Print end status message
echo
echo "Backup finished!"
date
ls -lh "$archive_file"
