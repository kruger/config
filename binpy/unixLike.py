# From ActiveState Cookbook
# Recipe 276960: Shell-like data processing
#
# Python has several functions that do operate on sequential data, a.e.
# filter, map, zip, sum, etc. However, to do some complicated processing
# one has to introduce intermediate variables, or build complex nested
# function calls or list comrehencions. This is not as elegant as, for
# example, unix shell command "cat foo.bar | grep smth | sort | uniq".
#
# Inspired by a "C++-like iostream" recipe by Erik Max Francis (no.
# 157034 in this cookbook), i made this quick-hack emulation of shell
# pipe syntax. The main advantage of such syntax is that the distinct
# operations in a sequence are located between |'s, so there is no
# # messing brackets, and no extra variables too.
#
# This is also useful in interactive mode, to see the content of a
# generator. It seems easier to add "| aslist" at the end of an
# expression than to enclose the whole expression in list(...)
# constructor.
# 
# Note also, that everything here makes use of generators when possible,
# so no extra memory is consumed during processing.
#
#######################
# example 1: equivalent to shell grep ".*/bin/bash" /etc/passwd
# cat('/etc/passwd') | tr(str.rstrip) | grep('.*/bin/bash') | printlines

#######################
# example 2: get a list of int's methods beginning with '__r'
# dir(int) | grep('__r') | aslist

#######################
# example 3: useless; returns a dict {0:'l',1:'a',2:'m',3:'b',4:'d',5:'a'} 
# 'lambda' | enum | asdict
from itertools import izip, imap, count, ifilter
import re

def cat(fname):
    return file(fname).xreadlines()

class grep:
    """keep only lines that match the regexp"""
    def __init__(self,pat,flags=0):
        self.fun = re.compile(pat,flags).match
    def __ror__(self,input):
        return ifilter(self.fun,input)

class tr:
    """apply arbitrary transform to each sequence element"""
    def __init__(self,transform):
        self.tr=transform
    def __ror__(self,input):
        return imap(self.tr,input)

class printlines_class:
    """print sequence elements one per line"""
    def __ror__(self,input):
        for l in input:
            print l

printlines=printlines_class()

class terminator:
    """to be used at the end of a pipe-sequence"""
    def __init__(self,method):
        self.process=method
    def __ror__(self,input):
        return self.process(input)

# From the comments section
class match:
    """keep only lines that match the regexp"""
    def __init__(self, pat, flags=0, method='match'):
        self.fun = getattr(re.compile(pat, flags), method)
    def __ror__(self, input):
        return ifilter(self.fun, input)

class search(match):
    def __init__(self, pat, flags=0):
        match.__init__(self, pat, flags, method='search')

grep = search

class writelines:
    "write each item to a file like object"
    def __init__(self, f):
        self.file = f
    def __ror__(self, input):
        for l in input:
            self.file.write(l)

printlines = writelines(sys.stdout)
# those objects transform generator to list, tuple or dict
aslist  = terminator(list)
asdict  = terminator(dict)
astuple = terminator(tuple)

# this object transforms seq to tuple sequence
enum = terminator( lambda input: izip(count(),input) )

#######################
# example 1: equivalent to shell grep ".*/bin/bash" /etc/passwd
# cat('/etc/passwd') | tr(str.rstrip) | grep('.*/bin/bash') | printlines

#######################
# example 2: get a list of int's methods beginning with '__r'
# dir(int) | grep('__r') | aslist

#######################
# example 3: useless; returns a dict {0:'l',1:'a',2:'m',3:'b',4:'d',5:'a'} 
# 'lambda' | enum | asdict
