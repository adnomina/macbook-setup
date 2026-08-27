#!/bin/bash

input=$(cat)

CWD=$(echo "$input" | jq -r '.workspace.current_dir')
MODEL=$(echo "$input" | jq -r '.model.display_name')
CONTEXT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd' | xargs printf "%.2f")

echo "📁 ${CWD##*/} | 🤖 $MODEL | 🧠 ${CONTEXT}% | 💵 \$${COST}"
