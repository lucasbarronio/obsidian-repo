#!/bin/bash
slugify() {
  echo "$1" | 
    iconv -t ascii//TRANSLIT |
    tr -d "'" | 
    tr '[:upper:]' '[:lower:]' |
    sed 's/[^a-z0-9]/-/g' |
    sed 's/-\+/-/g' |
    sed 's/^-//;s/-$//'
}

find content -type f -name "*.md" | while read -r file; do
  filename=$(basename "$file" .md)
  slug=$(slugify "$filename")
  
  sed -i -E "s/\[\[${filename}\]\]/[${filename}](${slug}.md)/g" "$file"
done
