#!/bin/bash
lsof | grep "iTunes/iTunes\ Music" | cut -d/ -f7-9 | sed -e 's/\//-/g' | cut -d. -f1
