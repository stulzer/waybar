#!/bin/bash

# Repo updates (pacman-contrib provides `checkupdates`)
core_count=$(checkupdates 2>/dev/null | wc -l)

# AUR updates via paru
aur_count=$(paru -Qua 2>/dev/null | wc -l)

total=$((core_count + aur_count))

if [ "$total" -eq 0 ]; then
    echo '{"text":"󰗠", "tooltip":"Up to date"}'
    exit 0
fi

if [ "$core_count" -gt 0 ] && [ "$aur_count" -gt 0 ]; then
    tooltip="• $core_count core packages outdated\n• $aur_count AUR packages outdated"
elif [ "$core_count" -gt 0 ]; then
    tooltip="• $core_count core packages outdated"
else
    tooltip="• $aur_count AUR packages outdated"
fi

echo "{\"text\":\"󱍷\", \"tooltip\":\"$tooltip\"}"
