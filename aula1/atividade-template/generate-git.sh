#!/bin/bash

read -p "Please enter the project name: " name
if [ -n "$name" ]; then
  echo "Hello, $name!"
  cp -r /template $name
  cd $name
  sed -i 's/name/$name/g' readme.md
  

  #parte do git
else
  echo "No project name provided."
  exit 1
fi