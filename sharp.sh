#!/usr/bin/env bash

while IFS= read line || [[ -n "${line}" ]]; do
  test=$(echo -e "${line}" | tr -d '\b')
  while [[ "${#test}" != "${#line}" ]]; do
    line=$(echo -e "${line}" | sed 's/[^\b]\b//')
    test=$(echo -e "${line}" | tr -d '\b')
  done && true
  feed=
  IFS=$'\r'
  for part in $line; do
    [[ ${#part} < ${#feed} ]] && feed="${part}${feed:${#part}}" || feed="${part}"
  done && true
  echo -e "${feed}" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'
done && true
