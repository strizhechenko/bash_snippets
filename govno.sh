#!/bin/bash

set -eu

script_list() {
	grep -r '#!/bin/bash' "${1:-.}" 2>/dev/null | cut -d ':' -f1
}

script_check() {
	echo -n "$1 "
	shellcheck "$1" | fgrep -c '^-- ' || true
}

directory_lint() {
	script_list "$@" | while read script; do
		script_check "$script"
	done | sort -nrk2
}

directory_lint "$@"
