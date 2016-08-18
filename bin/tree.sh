#!/bin/sh
ls -RF | grep ":$" | \
  sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'

