#!/bin/bash

MAX_LIST=10
MAX_NAME=40

mapfile -t core_updates < <(checkupdates 2>/dev/null)
mapfile -t aur_updates < <(paru -Qua 2>/dev/null)

core_count=${#core_updates[@]}
aur_count=${#aur_updates[@]}

if [ "$((core_count + aur_count))" -eq 0 ]; then
    echo '{"text":"󰗠", "tooltip":"Up to date"}'
    exit 0
fi

build_section() {
    local header="$1"; shift
    local count=$#
    local out="$header"
    local shown=0 name
    for pkg in "$@"; do
        [ "$shown" -ge "$MAX_LIST" ] && break
        name="${pkg%% *}"
        if [ ${#name} -gt $MAX_NAME ]; then
            name="${name:0:$((MAX_NAME - 1))}…"
        fi
        out+="\\n  • $name"
        shown=$((shown + 1))
    done
    if [ "$count" -gt "$MAX_LIST" ]; then
        out+="\\n  … and $((count - MAX_LIST)) more"
    fi
    printf '%s' "$out"
}

tooltip=""
if [ "$core_count" -gt 0 ]; then
    tooltip=$(build_section "• $core_count core packages outdated" "${core_updates[@]}")
fi

if [ "$aur_count" -gt 0 ]; then
    section=$(build_section "• $aur_count AUR packages outdated" "${aur_updates[@]}")
    if [ -n "$tooltip" ]; then
        tooltip="${tooltip}\\n\\n${section}"
    else
        tooltip="$section"
    fi
fi

printf '{"text":"󱍷", "tooltip":"%s"}\n' "$tooltip"
