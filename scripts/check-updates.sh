#!/bin/bash

updates=$(checkupdates 2>/dev/null)
count=$(echo "$updates" | grep -c '^')

if [ -n "$updates" ]; then
    echo "{\"text\":\"󱍷\", \"tooltip\":\"$count update(s) available\"}"
else
    echo "{\"text\":\"󰗠\", \"tooltip\":\"Up to date\"}"
fi
