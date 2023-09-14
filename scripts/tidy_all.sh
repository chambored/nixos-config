#!/run/current-system/sw/bin/bash

# Prompt the user for confirmation
read -p "Are you sure you want to run 'tidy' on all HTML files in this directory and its subdirectories? (y/n) " -n 1 -r
echo    # Move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Find all HTML files recursively and run tidy on them
    find . -name "*.html" -type f -exec tidy -m {} \;
    echo "Tidy operation completed!"
else
    echo "Operation aborted."
fi

