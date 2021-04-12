#!/usr/bin/env python

import optparse
from pathlib import Path
import os

def makeLinks(root_name):

    root=Path(root_name)

    if not root.exists():
        print("Does not exist: ", root_name)
        return

    cur_dir=Path('.').absolute()
    if not cur_dir.name == root.name:
        Path(root.name).mkdir()
        os.chdir(root.name)
        cur_dir=Path('.').absolute()
    
    file_entries=[]
    for pres in root.rglob('*'):
        sfx_match=['.rst']
        if pres.suffix in sfx_match:
            print(pres)
            rel_pres=pres.relative_to(root)
            rel_pres.parent.mkdir(parents=True, exist_ok=True)
            rel_pres.symlink_to(cur_dir)

    return 


def main():
    parser = optparse.OptionParser(usage="%prog [options] root")
    options, args = parser.parse_args()

    # Process arguments
    if len(args) > 1:
        parser.print_usage()
        return
    elif len(args) == 1:
        root = args[0]

    df=makeLinks(root)
    return


if __name__ == "__main__":
        main()
