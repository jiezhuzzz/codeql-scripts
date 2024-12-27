#! /bin/bash

# this script is used to install codeql on a linux machine

wget codeql-bundle-linux64.tar.gz https://github.com/github/codeql-action/releases/download/codeql-bundle-v2.20.0/codeql-bundle-linux64.tar.gz
tar -C $HOME/.local/ -xvzf codeql-bundle-linux64.tar.gz

echo "export PATH=\$HOME/.local/codeql:\$PATH" >> $HOME/.bashrc
echo "CodeQL installed to $HOME/.local/codeql"
rm codeql-bundle-linux64.tar.gz
