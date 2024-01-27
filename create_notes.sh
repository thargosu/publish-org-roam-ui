#!/bin/bash

org_path=$1

mkdir -p notes

cat graphdata.json |
jq -c '.data.nodes[]' |
while read -r nodes; do
  id=$(echo "${nodes}" | jq -r '.id')
  file=$(echo "${nodes}" | jq -r '.file')
  echo "============================="
  
  timestamp=$(echo "${file}" | cut -d'-' -f1)
  matching_file=$(find "${org_path}" -name "${timestamp}-*.org" -type f)
  
  if [[ -f "${matching_file}" ]]; then
    cp -p "${matching_file}" "notes/${id}"
  fi
done
