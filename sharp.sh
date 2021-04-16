#!/usr/bin/env bash

while IFS= read line || [[ -n "${line}" ]]; do
  test=$(echo -e "${line}" | tr -d '\b')
  while [[ "${#test}" != "${#line}" ]]; do
    line=$(echo -e "${line}" | sed 's/[^\b]\b//')
    test=$(echo -e "${line}" | tr -d '\b')
  done && true
  echo -e "${line}" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'
done && true
