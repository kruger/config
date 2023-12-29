#!/usr/bin/env python
"""
Class for Organizing pdfs of papers oriented around pdf2doi

Goals:
  1. Embed bib information into the pdf
"""
import argparse
import glob
import os
import shutil
import sys
import pdf2bib as p2b
from pdfrenamer.filename_creators import (
    build_filename,
    AllowedTags,
    check_format_is_valid,
)
from pypdf import PdfReader, PdfWriter


sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from download_arxiv import *


def attach_bib(old_file, new_file, bib_str):
    """
    Attach a bib file to a pdf in a new_file.
    """
    # Attach bibtex info. See: https://www.ctan.org/pkg/intopdf
    # Here is a command to get it from the file:
    #   pdfdetach -saveall Taheri_et_al-Comput_Phys_Commun-2022.pdf
    reader = PdfReader(old_file)
    writer = PdfWriter()
    writer.append_pages_from_reader(reader)
    writer.add_attachment("paper.bib", bib_str)
    # Make sure the directories are avaialbe for writing
    with open(new_file, "wb") as file:
        writer.write(file)
    return


class PdfOrganizer:
    def __init__(self, options=None):
        """Constructor does base validation and file checks"""
        self.verbose = options.verbose
        self.files = []
        for ifile in options.files:
            if os.path.isdir(ifile):
                self.files += glob.glob(dir + "/*.pdf")
            elif not os.path.exists(ifile):
                print("File not found: ", ifile)
                continue
            self.files.append(ifile)
        if not self.files:
            raise FileNotFoundError("No existing files found.")

        home = os.environ.get("HOME")

        # Configure pdf2bib.  Inheritance is a bit crazy here
        p2b.config.set("verbose", self.verbose)

        # Where to store the unmodified directory
        self.savedir = None  # leave where it is
        # self.savedir = "Processed"  # subdir named Processed
        if self.savedir:
            os.makedirs(self.savedir, exist_ok=True)

        # Root directory of Papers
        self.papers_dir = os.path.join(home, "Papers", "Library")

        # Root directory of Journal articles
        self.journals_dir = os.path.join(self.papers_dir, "Journals")

        # Root directory of Journal articles
        self.arxiv_dir = os.path.join(self.papers_dir, "Arxiv")

        # Where to store bibfiles
        self.bibdir = os.path.join(self.papers_dir, "Bibtex")

        # This comes from pdf2renamer
        self.format = "{Aetal}-{Jabbr}-{YYYY}"

        # This is the format of the subdirectories that they are stored in
        # The "/" is needed to get the subdirectory structure
        self.dir_format = "{J}-{YYYY}"

        return

    def _is_int(self, input_string):
        """ Return whether it is an integer
        """
        try:
            int(input_string)
            return True
        except ValueError:
            return False

    def _is_arxiv(self, filenm):
        """ One way to determine whether an arxiv paper is to get the bib
            info and determine based on that -- pdfrename has tools as well
            But a faster way is to key off of the filename and just assume that
            no journal uses the same scheme.
        """
        flnm_splt = filenm.split('.')
        if len(flnm_splt) != 3:
            return False
        # First string should be 4 characters long
        if len(flnm_splt[0]) != 4:
            return False
        # First, second split are integers (written to be LSP friendly)
        is_int = self._is_int(flnm_splt[0]) and self._is_int(flnm_splt[1])
        if not is_int:
            return False
        # Early arxiv papers have 4 integers in second part.  Newer 5
        if len(flnm_split[1]) > 5:
            return False
        return True

    def vprint(self, message):
        """Decide what to do depending on what was given"""
        if self.verbose:
            print(message)
        return

    def run(self):
        """Decide what to do depending on what was given"""
        self.organize()
        return

    def organize(self):
        """Go through each file and:
        1. Figure out whether doi info can be found (pdf2doi)
        2. Extract the associated bibinfo (pdf2bib)
        3. Add the bibinfo to the pdf and save it into a new filename

        pdfrename has tools for arxiv files, but I prefer to use
        a completely different workflow because arxiv web api
        gives a richer interface for categorization
        """
        arxiv_files = []
        for pfile in self.files:
            print(f"Processing: {pfile}")
            if self._is_arxiv:
                arxiv_files.append(pfile)
                continue
            # This is key ingredient: get the bibinfo from the pdf
            result = p2b.pdf2bib(pfile)
            if result["metadata"] and result["identifier"]:
                # Use pdfrenamer to get file and directory names
                metadata = result["metadata"].copy()
                bibinfo = result["bibtex"]
                tags = check_format_is_valid(self.format)
                label = build_filename(metadata, self.format, tags)
                dir_name = build_filename(metadata, self.dir_format, tags)
                mod_subdir = dir_name.replace("-", "/")
                mod_label = self.get_label(label, mod_subdir)
                pdf_file = os.path.join(
                    self.journals_dir, mod_subdir, mod_label + ".pdf"
                )
                bib_file = os.path.join(self.bibdir, mod_label + ".bib")

                # This is all of the action
                print("\tLabel from doi: ", mod_label)
                self.vprint("\tRename file with bib attached")
                attach_bib(pfile, pdf_file, bibinfo)
                self.vprint("\tWrite bib file")
                with open(bib_file, "w") as fh:
                    fh.write(bibinfo)
                if self.savedir:
                    self.vprint(f"\tMove file to {self.savedir}")
                    shutil.move(pfile, self.savedir)
            else:
                print(f"Could not identify {pfile}")

        # This handles all of the arxiv files completely separately
        if arxiv_files:
            arxiv_parser = parse_pdfdownload_args()
            arxiv_args = arxiv_parser.parse_args(arxiv_files)
            arxiver = PdfDownloader(arxiv_args)
            arxiver.run()
 
        return

    def get_label(self, lbl, subdir):
        """
        Two things:
        1. Fix the labeling to match my tastes
           (don't like how pdfrenamer does it)
        2. Make sure we do not overwrite pdf file
        """
        label = (
            lbl.replace(".", "")
            .replace(" ", "_")
            .replace("_et_al", "")
            .replace("_&amp;_", "&")
        )

        # TODO: Check to see if bibfile exists, has the same doi, and then
        #   avoid dupes
        write_dir = os.path.join(self.journals_dir, subdir)
        os.makedirs(write_dir, exist_ok=True)
        i = 0
        try_lbl = label
        while 1:
            pdf_file = os.path.join(write_dir, try_lbl + ".pdf")
            if os.path.exists(pdf_file):
                try_lbl = try_lbl + "_" + str(i)
                i += 1
            else:
                break
        return try_lbl


def parse_pdforganize_args():
    """
    General arguments that control the organizing
    """
    desc = "Organize a pdf file from file containing the URLs"
    desc += ", or sort files in a directory"
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument("files", type=str, nargs="+", help="File(s) containing the URL")
    parser.add_argument(
        "-v", "--verbose", help="Verbose output", dest="verbose", action="store_true"
    )
    return parser


def main():
    """
    Parse arguments and act accordingly
    """
    parser = parse_pdforganize_args()
    args = parser.parse_args()

    organizer = PdfOrganizer(args)
    organizer.run()


if __name__ == "__main__":
    main()
