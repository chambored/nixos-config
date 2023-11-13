#!/run/current-system/sw/bin/bash

# Check if pptx2md is installed
if ! command -v pptx2md &> /dev/null; then
    echo "Error: pptx2md is not installed. Please install it using 'pip install pptx2md'."
    exit 1
fi

# Create the md_lectures directory
mkdir -p md_lectures/imgs

# Find all PPTX files recursively
find . -type f -name "*.pptx" | while read pptx_file; do
    # Get the filename without the extension
    base_name=$(basename "$pptx_file" .pptx)
    
    # Convert the PPTX file to markdown
    pptx2md "$pptx_file" -i "md_lectures/imgs/$base_name" > "md_lectures/$base_name.md"
done

echo "Conversion complete. Markdown files are saved in the md_lectures directory."

