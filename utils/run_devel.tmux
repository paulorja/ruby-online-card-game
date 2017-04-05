#!/usr/bin/tmux source-file

new-session -d
split-window -d -t 0 -v
split-window -d  -h 

send-keys -t 0 'DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; cd /$DIR; sleep 1; ruby client.rb' enter

send-keys -t 1 'DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; cd $DIR ;  sleep 1; ruby client.rb' enter

send-keys -t 2 'DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" ; cd $DIR ; cd .. ; ruby start_server.rb' enter 
attach
