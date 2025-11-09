#!/bin/bash

# Raycast 元数据
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Common Sites
# @raycast.mode fullOutput
# @raycast.description List of commonly used websites with actions.
#
# Optional parameters:
# @raycast.icon 🌐

# 使用 heredoc 语法方便地输出多行 JSON
cat <<EOF
{
  "items": [
    {
      "title": "GitHub",
      "subtitle": "github.com",
      "accessories": [{ "text": "Code Hosting" }],
      "actions": [
        {
          "title": "Open in Browser",
          "type": "open",
          "target": "https://github.com"
        },
        {
          "title": "Copy URL",
          "type": "copy",
          "content": "https://github.com",
          "shortcut": { "modifiers": ["cmd"], "key": "c" }
        }
      ]
    },
    {
      "title": "Raycast Documentation",
      "subtitle": "developers.raycast.com",
      "accessories": [{ "text": "Dev Docs" }],
      "actions": [
        {
          "title": "Open Docs",
          "type": "open",
          "target": "https://developers.raycast.com"
        },
        {
          "title": "Copy URL",
          "type": "copy",
          "content": "https://developers.raycast.com"
        }
      ]
    }
  ]
}
EOF