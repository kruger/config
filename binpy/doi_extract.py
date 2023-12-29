#!/usr/bin/env python

import optparse
import glob
import re
import os
import subprocess

# This is from cross ref, but I can't get it to work
# doi_re=re.compile('/^10.\d{4,9}/[-._;()/:A-Z0-9]+$/i')
# This works pretty well, but doesn't match this one:
# 10.1088/0029-5515/55/2/023012
# TODO:  Figure out the regex for this
# doi_re=re.compile('10\.\d*\/\d*\.\d*')
doi_re = re.compile("10\.\d*\/\d*")


def parse_line(line):
    if "http" in line.lower():
        toclean = "http" + line.split("http")[1].split()[0]
        doi_str = toclean.strip().rstrip(")").rstrip("]")
    elif "doi:" in line.lower():
        doi_str = line.lower().split("doi:")[1].strip()
        print(doi_str)
        doi_str = doi_re.match(doi_str).group()
    else:
        print("Problem in finding doi: " + line)
        doi_str = None
    return doi_str


def extract_doi(file):
    doi = None
    with open(file, encoding="utf-8", errors="ignore") as fh:
        data = fh.read()
        # print(data.split('\n'))
        nlines = len(data.split("\n"))
        i = 0
        for line in data.split("\n"):
            # print(line)

            if line.startswith("arXiv:"):
                doi = line.split()[0]
                break
            if "doi:" in line.lower() or "doi." in line.lower():
                doi = parse_line(line)
            # References have doi's so only search first half for DOI
            i += 1
            if i == int(nlines / 2):
                break
    if not doi:
        print("DOI not found")
    return doi


def write_bib(file, doi):
    outfile = os.path.splitext(file)[0] + ".bib"
    input_files = ["file1", "file2", "file3"]
    if "http" in doi:
        # Quotes here are annoying
        my_cmd = 'curl -LH "Accept: application/x-bibtex" ' + doi
        # print(my_cmd)
        with open(outfile, "w") as ofh:
            p = subprocess.Popen(my_cmd, shell=True, stdout=ofh)
    elif "arxiv" in doi.lower():
        arxiv = doi.split(":")[1]
        my_cmd = ["arxiv2bib", arxiv]
        # print(my_cmd)
        with open(outfile, "w") as ofh:
            subprocess.run(my_cmd, stdout=ofh)
    else:
        my_cmd = ["betterbib", "doi-to-bibtex", doi]
        print(my_cmd)
        with open(outfile, "w") as ofh:
            subprocess.run(my_cmd, stdout=ofh, shell=True)
    return


def main():
    parser = optparse.OptionParser(usage="%prog [options] inputFile")
    parser.add_option(
        "-i",
        "--input",
        dest="input",
        help="Name of input file if not specified as argument.",
        default="",
    )
    parser.add_option(
        "-d",
        "--do",
        dest="doSomething",
        help="Set a logical variable (default is true) ",
        action="store_true",
    )
    parser.add_option(
        "-n",
        "--number",
        dest="number",
        default="20",
        help="Number of something to control something else",
    )

    options, args = parser.parse_args()

    # Process arguments
    if len(args) > 1:
        parser.print_usage()
        return
    elif len(args) == 1:
        inputFile = args[0]
    else:
        if options.input == "":
            print("Must specify an input file")
            return
        else:
            inputFile = options.input

    # If output not written, then just write to stdout:
    doi = extract_doi(inputFile)
    print(doi)
    if doi:
        write_bib(inputFile, doi)


if __name__ == "__main__":
    main()
