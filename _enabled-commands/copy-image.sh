#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Image from Clipboard
# @raycast.mode compact
# @raycast.packageName Productivity
# @raycast.icon 🖼️

# Optional parameters:
# @raycast.argument1 { "type": "dropdown", "placeholder": "Target Location", "defaultValue": "$HOME/repos/chenke567/dotfiles/images/|./images/", "data": [{"title": "dotfile", "value": "$HOME/repos/chenke567/dotfiles/images/|./images/"}] }

# Documentation:
# @raycast.description Copies an image from the clipboard to a specified directory and returns a Markdown image link.
# @raycast.author chenke567
# @raycast.authorURL https://github.com/chenke567

# Main logic goes here

# Check for pngpaste dependency
if ! command -v pngpaste &> /dev/null; then
    echo "Error: pngpaste is not installed."
    echo "Please install it using Homebrew: brew install pngpaste"
    exit 1
fi

# Get arguments
IMAGE_NAME="$(date +%Y%m%d%H%M%S)-$RANDOM"
SELECTED_LOCATION_VALUE="$1" # Value from dropdown: path|url_prefix

# Split selected location value
IFS='|' read -r TARGET_DIRECTORY IMAGE_URL_PREFIX <<< "$SELECTED_LOCATION_VALUE"
image.png
# Expand path with tilde or environment variables
TARGET_DIRECTORY=$(eval echo "$TARGET_DIRECTORY")

# Validate selected directory
if [ ! -d "$TARGET_DIRECTORY" ]; then
    echo "Error: Target directory '$TARGET_DIRECTORY' does not exist."
    exit 1
fi

# Create a temporary file for the image
TEMP_IMAGE_PATH=$(mktemp /tmp/clipboard_image_XXXXXX.png)

# Save clipboard image to temporary file
pngpaste "$TEMP_IMAGE_PATH"

# Check if image was successfully pasted
if [ ! -s "$TEMP_IMAGE_PATH" ]; then
    echo "Error: No image found in clipboard or pngpaste failed."
    rm "$TEMP_IMAGE_PATH"
    exit 1
fi

# Define final image path
FINAL_IMAGE_NAME="${IMAGE_NAME}.png"
FINAL_IMAGE_PATH="${TARGET_DIRECTORY}/${FINAL_IMAGE_NAME}"

# Move image to target directory
mv "$TEMP_IMAGE_PATH" "$FINAL_IMAGE_PATH"

# Generate Markdown link
MARKDOWN_LINK="![](${IMAGE_URL_PREFIX}${FINAL_IMAGE_NAME})"

# Copy Markdown link to clipboard
echo "$MARKDOWN_LINK" | pbcopy

# Output Markdown link
# echo "$MARKDOWN_LINK"