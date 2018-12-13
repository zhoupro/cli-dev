#!/bin/bash
trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}
cnt=$(tail  "$1/cscope.out" | grep -e "\.c$" | wc -l)
trim   $cnt
