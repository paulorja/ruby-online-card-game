#!/bin/bash
if tmux -V 1> /dev/null  ; then
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	SCRIPT="$(echo $0 | sed s/'.sh'/'.tmux'/)"
	exec $DIR/$SCRIPT
else
	echo "Problem with tmux dependence"
	which tmux    
	exit 1
fi

