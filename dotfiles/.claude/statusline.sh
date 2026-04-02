#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
CTX=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
TKIN=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0' | cut -d. -f1)
TKOUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0' | cut -d. -f1)

# ${DIR##*/} extracts just the folder name
echo "📂 ${DIR##*/} | 🤖 $MODEL | 🧠 ${CTX} % | ⬆️ ${TKIN} | ⬇️ ${TKOUT}"
