#!/bin/bash
for I in *.*; do
  NOEXT=$(echo -n "${I}" | sed 's/\.[^.]*$//')
  if [ "${NOEXT}" != "README" ]; then
    echo -n "${NOEXT} "
  fi;
done
echo
