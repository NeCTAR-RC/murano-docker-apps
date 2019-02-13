#!/bin/bash

DIR="$1"

function run_check() {
    local e_count=0

    while read -d '' -r script; do
        unset RESULT
        shellcheck "${script}" -e SC1091,SC2001
        RESULT=$?
        if [ ${RESULT} != 0 ]; then
            ((e_count++))
        fi
    done < <(find "${DIR}" -name '*.sh' -print0)
	echo "shellcheck finished with ${e_count} errors."
    if [ "${e_count}" -gt 0 ] ; then
        exit 1
    fi
}

if [[ -z "$DIR" ]]; then
   echo 'ERROR: Dir is not set!'
   exit 1
fi
run_check
