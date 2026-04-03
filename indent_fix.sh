#!/bin/bash
# Script to standardize Lua file indentation to 4 spaces

echo "Standardizing Lua file indentation to 4 spaces..."

# Find all Lua files and convert tabs to 4 spaces
find . -name "*.lua" -type f -not -path "./.git/*" -not -path "./indent_fix.sh" | while read file; do
    echo "Processing: $file"
    
    # Create a temporary file
    TMP_FILE=$(mktemp)
    
    # Convert tabs to 4 spaces
    expand -t 4 "$file" > "$TMP_FILE"
    
    # Replace original with processed version
    mv "$TMP_FILE" "$file"
done

echo "Indentation standardization complete!"
echo "Note: This script converted tabs to 4 spaces."
echo "For more sophisticated indentation fixes, consider using a Lua formatter like lua-format."