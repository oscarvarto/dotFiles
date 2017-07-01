#!/usr/bin/env zsh

emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" 2> /dev/null | grep t &> /dev/null
if [ "$?" -eq "1" ]; then
    emacsclient -c -q -nw -a "" "$@" 2> /dev/null
else
    emacsclient -q -nw -a "" "$@" 2> /dev/null
fi
