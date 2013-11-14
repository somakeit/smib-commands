#!/bin/bash

if [ ! -d seen/$2 ]; then
  mkdir -p seen/$2
fi

echo $4 > seen/$2/$1
