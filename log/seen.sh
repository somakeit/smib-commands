#!/bin/bash

who=$(echo ${1,,} | tr '[\\~\[]' '[|^{]' | tr ']' '}')

if [ ! -d seen/$2 ]; then
  mkdir -p seen/$2
fi

echo $4 > seen/$2/$who
