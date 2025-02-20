#! /bin/bash
# This script installs the CodeQL CLI tool locally
#
# Prerequisites:
#   - wget
#   - tar
#   - bash shell
#
# The script will:
#   1. Download CodeQL bundle from GitHub
#   2. Extract it to ~/.local/codeql/
#   3. Add CodeQL to PATH in .bashrc
#   4. Clean up downloaded archive

while getopts "h" opt; do
    case $opt in
        h)
            echo "Usage: ./install.sh"
            echo "Installs CodeQL CLI to ~/.local/codeql and adds it to PATH"
            echo ""
            echo "Options:"
            echo "  -h    Show this help message"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# this script is used to install codeql on a linux machine

wget codeql-bundle-linux64.tar.gz https://github.com/github/codeql-action/releases/download/codeql-bundle-v2.20.0/codeql-bundle-linux64.tar.gz
tar -C $HOME/.local/ -xvzf codeql-bundle-linux64.tar.gz

echo "export PATH=\$HOME/.local/codeql:\$PATH" >> $HOME/.bashrc
echo "CodeQL installed to $HOME/.local/codeql"
rm codeql-bundle-linux64.tar.gz
