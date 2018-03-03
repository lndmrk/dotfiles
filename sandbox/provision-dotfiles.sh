#!/bin/bash

cd /vagrant
./setup
for dir in common local; do
  if [[ -d "${dir}" ]]; then
    (cd "${dir}" && stow */)
  fi
done
