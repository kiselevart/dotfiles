#!/bin/bash

# Hardcoded repository paths
repos=(
  "$HOME/books"
  "$HOME/misc/dotfiles"
  "$HOME/comp-prog"
  "$HOME/obsidian"
  "$HOME/papers"
  # Add more paths as needed
)

# Loop through all hardcoded repository paths
for repo in "${repos[@]}"; do
  if [ -d "$repo" ]; then
    echo "Processing repository: $repo"
    cd "$repo" || { echo "Failed to access $repo"; continue; }
    
    # Stage all changes
    git add .
    
    # Create a commit with the current date in the message
    commit_msg="backup for $(date +'%Y-%m-%d')"
    git commit -m "$commit_msg"
    
    # Push the changes to the remote repository
    git push

    # Return to the original directory
    cd - > /dev/null
  else
    echo "Directory '$repo' does not exist."
  fi
done


