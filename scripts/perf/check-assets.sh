#!/usr/bin/env bash
set -euo pipefail

# codex-os-managed
max_bytes="${ASSET_MAX_BYTES:-350000}"
mkdir -p .perf-results

roots=()
[[ -d public ]] && roots+=("public")
[[ -d dist/assets ]] && roots+=("dist/assets")

if (( ${#roots[@]} == 0 )); then
  cat > .perf-results/assets.json <<JSON
{"status":"not-run","checkedFiles":0,"maxBytes":$max_bytes,"roots":[]}
JSON
  echo "No asset roots found; skipping asset check."
  exit 0
fi

fail=0
checked=0
largest_file=""
largest_size=0

while IFS= read -r file; do
  size=$(wc -c < "$file")
  checked=$((checked + 1))
  if (( size > largest_size )); then
    largest_size=$size
    largest_file="$file"
  fi
  if (( size > max_bytes )); then
    echo "Asset too large (>${max_bytes} bytes): $file"
    fail=1
  fi
done < <(find "${roots[@]}" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" -o -name "*.avif" -o -name "*.svg" -o -name "*.js" -o -name "*.css" \))

status="pass"
if (( fail != 0 )); then
  status="fail"
fi

roots_json=$(printf '"%s",' "${roots[@]}")
roots_json="[${roots_json%,}]"
largest_file_json="null"
if [[ -n "$largest_file" ]]; then
  largest_file_json="\"$largest_file\""
fi

cat > .perf-results/assets.json <<JSON
{
  "status": "$status",
  "checkedFiles": $checked,
  "maxBytes": $max_bytes,
  "roots": $roots_json,
  "largestFile": $largest_file_json,
  "largestBytes": $largest_size
}
JSON

exit $fail
