#!/bin/bash

nohup $@  1> $1.out  2>&1 </dev/null &
exit
