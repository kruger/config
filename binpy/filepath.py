#!/usr/bin/env python

import optparse
import os
from pathlib import Path
import shutil
import time

def touch(path):
    with open(path, 'a'):
        os.utime(path, None)

def pathdo(source, destination):
    """
    Given two paths, do something
    """
    s=Path(source)
    d=Path(destination)

    file_entries=[]
    for sresult in s.rglob('*'):
        if sresult.is_file() and not sresult.name.startswith('.'):
            dresult=d.joinpath(sresult.name)
            if dresult.is_file():
               dsize=dresult.stat().st_size
            else:
                dsize=0.
            ssize=sresult.stat().st_size
            # sync and then touch
            if ssize > dsize:
                print("Moving "+sresult.name+" to: "+destination)
                shutil.move(sresult, dresult)
                touch(sresult)
            # Didn't do it properly the first time
            elif ssize == dsize:
                sresult.unlink()
                touch(sresult)

            # Accidently overwrote files in library
            if dsize == 0:
                sresult.unlink()


	    #sresult.stat().name      # basename
	    #sresult.stat().parent    # dirname
	    #sresult.stat().parents   # list of parents
	    #sresult.stat().absolute  # abspath
	    #sresult.stat().st_ctime  # Created
	    #sresult.stat().st_mtime  # Modified
	    #sresult.stat().st_size   # Size
	    #sresult.suffix           # Extension

    return

def main():
    parser = optparse.OptionParser(usage="%prog [options] source dest")
    parser.add_option('-d', '--do', dest='doSomething',
                      help='Set a logical variable (default is true) ',
                      action='store_true')
    parser.add_option('-n', '--number', dest='number', default='20',
                      help='Number of something to control something else')

    options, args = parser.parse_args()

    # Process arguments
    if len(args) > 2:
        parser.print_usage()
        return
    elif len(args) == 2:
        source = args[0]
        destination = args[1]

    pathdo(source, destination)

    return


if __name__ == "__main__":
        main()
