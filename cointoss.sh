#!/bin/bash

if [ $(expr $RANDOM % 2) -eq '1' ]; then echo heads; else echo tails; fi
