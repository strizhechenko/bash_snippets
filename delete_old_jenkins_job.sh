#!/bin/bash

for i in /var/lib/jenkins/jobs/*; do
        find $i/builds/ -mindepth 1 -type d | head -n -"${1:-3}"
done | xargs rm -rfv
