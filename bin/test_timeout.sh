#!/usr/bin/env bash
# This works for pipe status
#cmd="sleep 200 2> test.err | grep -v run | grep -v ex > test.out 2>> test.err"
#eval "$cmd; typeset pid=$! -a cmd_errstat=(\${PIPESTATUS[@]})"
TIMEOUT=30

# test putting in background
echo "SHELL: "$$
#cmd="foo 2> test.err > test.out; typeset -a cmd_errstat=(\${PIPESTATUS[@]}) &"
cmd="sleep 1 2> test.err > test.out"
eval "($cmd) &"
pid=`jobs -p %1`
echo "PID: "$pid
#(sleep $TIMEOUT && echo $pid && kill -s PIPE $pid ) 2>&1 >/dev/null & let watcher=$!+1
#eval "(sleep $TIMEOUT && wpid=$1 && kill -s PIPE $pid  2>&1 >/dev/null) &"; watcher=$!
$PWD/watchtime.sh $pid $TIMEOUT &
watcher=$!
echo "WATCHER: "$watcher

wait $pid 2> /dev/null
res=$?
echo "Result: "$res
if ps -p $watcher > /dev/null; then
    kill -s PIPE $watcher 
    wait $watcher 2>/dev/null
    echo "your_command finished"
else
    if $kill_job; then
      echo "Exceeded timeout limit of $TIMEOUT" 
    fi
fi



