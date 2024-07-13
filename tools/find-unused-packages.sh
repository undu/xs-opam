#!/usr/bin/env bash

set -euo pipefail

export LANG=C
export LC_ALL=C

export OPAMCOLOR=NEVER

USED=$(opam list -t --required-by xs-toolstack --or --required-by dev-tools --recursive --short | sort)
PACKAGES=$(find "packages/" -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 -I {} echo "{}" | cut -d "/" -f 2 | sort | uniq)
diff -u .github/unused-packages.txt <(comm -23 <(echo "$PACKAGES") <(echo "$USED"))
echo OK
