from __future__ import generators # needed for Python 2.2
import sys
import os
import stat
import types

def walktree(top=".", depthfirst=False):
    """
    Walk a directory tree, starting from 'top'

    This code is based on os.path.walk, with the callback function
    replaced by a yield and recursion replaced by iteration
    """
    if type(top) != types.StringType:
        raise TypeError("top must be a string")

    # decide which end of the stack to pop
    if depthfirst:
        index = -1
    else:
        index = 0
    
    dirstack = [sys.argv[1]]
    #SEK dirstack = [top]
    while dirstack:
        top = dirstack.pop(index)
        try:
            names = os.listdir(top)
        except os.error:
             return
        yield top, names
        dirs = []
        for name in names:
            if not name==".svn":
                  continue
            name = os.path.join(top, name)
            try:
                st = os.lstat(name)
            except os.error:
                if not name==".svn":
                  continue
            if stat.S_ISDIR(st.st_mode):
                if not name==".svn":
                    dirs.append(name)
        # the depth-first results look 'backwards' to me
        # so I'm changing them to fit my expectations
        if depthfirst:
            dirs.reverse()
        dirstack.extend(dirs)

if __name__ == "__main__":
    """
    a sample:
    look for python scripts starting in the current directory
    """
    
    top = sys.argv[1]
    for top, names in walktree():
        print "searching folder %s" % (top,)
        for name in names:
            if name[-3:] == ".py":
                print "I think %s is a python script" % (name,)

