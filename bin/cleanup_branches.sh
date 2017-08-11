#!/bin/bash

echo "Repo: $(pwd)"
echo
echo "Fetching and pruning"
git fetch -p
echo
echo "Do you want to delete these branches?"
git branch -vv | awk '/\[.*: gone\]/ {print $1}'
echo
echo "Enter to continue. CTRL+C to cancel"
read
git branch -vv | awk '/\[.*: gone\]/ {print $1}' | xargs git branch -D
