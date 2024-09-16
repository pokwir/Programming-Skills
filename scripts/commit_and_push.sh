#!/bin/bash


#global vars 
set_user(){
    #promt for name and email
    read -p "Enter your First and Last Name: " NAME
    read -p "Enter your Email: " EMAIL
    git config --global user.name "$NAME"
    git config --global user.email "$EMAIL"
    echo "User has been set"
}

# Function to check if git is installed
check_git() {
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Please install Git to proceed."
        exit 1
    else
        echo "Git is installed."
    fi
}

# Function to check if the script is being run inside a git repository
check_git_repo() {
    if [ ! -d ".git" ]; then
        echo "This directory is not a Git repository. Please navigate to a valid Git repository."
        exit 1
    fi
}

# Function to add, commit, and push changes
commit_and_push() {
    # Add all changes
    git add .

    # Prompt for a commit message
    read -p "Enter your commit message: " COMMIT_MESSAGE

    # If commit message is empty, set a default message
    if [ -z "$COMMIT_MESSAGE" ]; then
        COMMIT_MESSAGE="Auto-commit: $(date)"
    fi

    # Commit the changes
    git commit -m "$COMMIT_MESSAGE"

    # Push changes to the current branch
    git push

    if [ $? -eq 0 ]; then
        echo "Changes successfully pushed to the repository!"
    else
        echo "Failed to push changes. Please check the error message above."
    fi
}

# Main function to check git and push the commit
main() {
    set_user
    check_git
    check_git_repo
    commit_and_push
}

# Execute the main function
main
