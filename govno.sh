#!/bin/bash

# deps: apt-get install shellcheck / brew install cabal && cabal install shellcheck
# usage: govno.sh git/bash_repo/
# usage: cd git/bash_repo/; govno.sh

set -eu

script_list() {
	grep -r '#!/bin/bash' "${1:-.}" 2>/dev/null | cut -d ':' -f1 | fgrep -v '.git' | sed -e 's|^\./||g' || true
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
