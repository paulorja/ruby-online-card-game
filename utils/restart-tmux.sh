#!/bin/bash

pid=" $(ps aux | grep -i '[c]lient.rb\|[s]tart_server.rb\|[r]un_devel' | awk '{ print $2 }')"
if [ "$pid" ] ; then
	kill -9 $pid 
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
bash run_devel.sh
