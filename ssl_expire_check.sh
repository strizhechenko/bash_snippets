#!/bin/bash

set -eu

if [ -z "${URL:-}" ]; then
	[ -n "$1" ] && URL="$1"
fi

get_expire_date() {
	curl -vsS "$URL" 2>&1 | grep expire | awk '{print $4" "$5" "$7}'
}

current_date() {
	LANG= date | awk '{print $2" "$3" "$6}'	
}

main() {
	local cur="$(current_date)"	
	local exp="$(get_expire_date)"
	read cur_month cur_day cur_year <<< "$cur"
	read exp_month exp_day exp_year <<< "$exp"
	[ "$cur_year" -gt "$exp_year" ] && return 1
	if [ "$exp_month" = "$cur_month" ]; then
		[ "$((exp_day - cur_day))" -lt "${MAX_EXPIRE:-10}" ] && return 2
	fi
	return 0
}

main
