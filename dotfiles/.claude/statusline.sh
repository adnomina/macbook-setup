#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
read -r CTX TOTAL < <(echo "$input" | jq -r '[
  (.context_window.used_percentage // 0 | floor),
  ((.context_window.current_usage.input_tokens // 0)
  + (.context_window.current_usage.cache_creation_input_tokens // 0)
  + (.context_window.current_usage.cache_read_input_tokens // 0))
] | @tsv')

if [ "$TOTAL" -ge 1000 ]; then
    TKFMT="$(echo "scale=1; $TOTAL / 1000" | bc)k"
else
    TKFMT="$TOTAL"
fi

# ${DIR##*/} extracts just the folder name
echo "📂 ${DIR##*/} | 🤖 $MODEL | 🧠 ${TKFMT} (${CTX} %)"
