#!/usr/bin/python
import sys

def parse_byfile(input):
      file_input=input.read()
      print file_input

def parse_byline(input):
      while 1:
    line=input.readline()
    if not line:
        break
    else:
        print line,

def parse_many(parser, arguments):
      for name in arguments:
            input=open(name, 'r')
        parser(input)
        input.close()

arguments=sys.argv[1:]
parse_many(parse_byline, arguments)
parse_many(parse_byfile, arguments)

