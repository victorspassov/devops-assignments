#!/bin/bash

[ -d ~/homework ] && echo "File already exists" || { echo "Creating file"; mkdir ~/homework; touch ~/homework/content.txt; } 

echo $(date) >> ~/homework/content.txt

n=$(wc -l ~/homework/content.txt | awk '{print $1}')
output=$(tail -n1 ~/homework/content.txt )

echo "The file contains $n line(s)"
echo "The last line states $output"