#!/bin/bash
for I in *; do
  if [ "$I" != "README.md" ]; then
    echo -n "${I/.*/} "
  fi;
done
echo
