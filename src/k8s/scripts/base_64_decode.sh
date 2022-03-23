#!/bin/bash

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: missed string to decode."
  exit 2
fi

str=$1

echo Encoding $str
echo ""
echo "$str" | base64 --decode
