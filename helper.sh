#!/bin/bash

cd ~/"$1"

number_of_files=$(ls -la | grep "^-" | wc | awk '{print $1}')
number=$(($number_of_files - 1))

# search maximum number of extensions
search_max_extensions=$(find . -maxdepth 1 -type f | awk -F . '{print tolower($NF)}' | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}')

# remove unnecessary extensions
find . -type f ! -name "*.$search_max_extensions" -exec rm -rf {} \;

# looks for empty files and deletes them
find . -type f -empty -exec rm {} \;

# finds the last file
last_file=$(ls -t | head -1)

# delete all files except the last one
ls | grep -v $last_file | xargs rm


language_extension=$(echo $last_file | sed 's/.*\.//')
language_extension=".$language_extension"

# create a .gitignore file and add text
touch .gitignore
printf "*.md 
*.txt 
*.docx 
*.xml
" >> .gitignore  

printf "You just helped $language_extension developer find the latest version of his code! .gitignore is created. $number files deleted.\n"
