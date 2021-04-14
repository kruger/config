#!/usr/bin/env python

import optparse
from pathlib import Path
import os


def make_links(root_name):
    """
    Go through root and find rst files.  Create links with the same structure
    """

    root = Path(root_name).absolute()
    if not root.exists():
        print("Does not exist: ", root_name)
        return

    # Always have the links in the same directory as the root name
    # for my convenience
    cur_dir = Path(".").absolute()
    if cur_dir.name != root.name:
        Path(root.name).mkdir()
        os.chdir(root.name)
        cur_dir = Path(".").absolute()

    sfx_match = [".rst"]
    for pres in root.rglob("*"):
        if pres.suffix in sfx_match:
            rel_pres = pres.relative_to(root)
            print(rel_pres)
            rel_pres.parent.mkdir(parents=True, exist_ok=True)
            rel_pres.symlink_to(pres)

    return


def main():
    """  Main body:  Process arguments, call above method
    """
    parser = optparse.OptionParser(usage="%prog [options] root")
    options, args = parser.parse_args()

    # Process arguments
    if len(args) > 1 or len(args) < 1:
        parser.print_usage()
        return

    make_links(args[0])
    return


if __name__ == "__main__":
    main()
