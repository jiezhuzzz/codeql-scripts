#! /bin/bash
# # Generate multiple CodeQL databases for a list of repositories in a directory

# Usage: ./gen_dbs.sh -d <directory> -- <repos>

# Parse command line arguments
while getopts "d:" opt; do
  case $opt in
    d)
      DB_DIR="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Shift past the options to get to the repos list
shift $((OPTIND-1))

# Check if directory is provided
if [ -z "$DB_DIR" ]; then
    echo "Error: Database directory (-d) must be specified"
    echo "Usage: ./gen_dbs.sh -d <directory> -- <repos>"
    exit 1
fi

# Check if any repos are provided
if [ $# -eq 0 ]; then
    echo "Error: No repositories specified"
    echo "Usage: ./gen_dbs.sh -d <directory> -- <repos>"
    exit 1
fi

# Create database directory if it doesn't exist
mkdir -p "$DB_DIR"

# Generate database for each repository
for repo in "$@"; do
    echo "Generating database for $repo"
    repo_name=$(basename "$repo")
    # Remove existing database if it exists
    if [ -d "$DB_DIR/$repo_name" ]; then
        echo "Removing existing database for $repo"
        rm -rf "$DB_DIR/$repo_name"
    fi
    # Create CodeQL database
    codeql database create "$DB_DIR/$repo_name" \
        --language=cpp \
        --source-root="$repo" || {
        echo "Failed to create database for $repo"
        continue
    }
    
    echo "Successfully created database for $repo"
done

echo "All databases generated in $DB_DIR"

