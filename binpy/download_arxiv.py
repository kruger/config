#!/usr/bin/env python
"""
Class for downloading pdfs where the URLs  are listed in a text file
Extract the DOI info along the way if possible
"""
import os
import shutil
import glob
import argparse
import requests
import arxiv2bib as a2b

sort_categories = {}
keywords = {}
# These are "physics.<Category>"
sort_categories['chem-ph'] = "Chemistry"
sort_categories['optics'] = "Photonics"
sort_categories['comp-ph'] = "CSE"
sort_categories['nucl-th'] = "Physics"
sort_categories['nucl-ex'] = "Physics"
sort_categories['hep-th'] = "Applied"
sort_categories['hep-ex'] = "Applied"
sort_categories['class-ph'] = "Physics"
sort_categories['hep-ph'] = "Physics"
sort_categories['ed'] = "Physics"
sort_categories['ed-phrt'] = "Physics"
sort_categories['hist-ph'] = "Physics/History"
sort_categories['astro-ph'] = "Plasma"
sort_categories['flu-dyn'] = "Plasma"
sort_categories['acc-ph'] = "Plasma/Accelerator"

# These two need additional sorting
sort_categories['plasm-ph'] = "Plasma"
sort_categories['app-ph'] = "Applied"
keywords["Plasma"] = {}
keywords["Plasma"]['Fusion'] = ['fusion', 'mhd', 'shafranov', 'gyrokinetic']
keywords["Plasma"]['Fusion'] += ['tokamak', 'divertor', 'stellarator']
keywords["Plasma"]['LTP'] = ['sheath', 'CCP', 'ICP', 'LTP', 'capacitively']
keywords["Plasma"]['LTP'] += ['polymer', 'low-temperature']
keywords["Plasma"]['Theory'] = ['Lie-perturbation']
keywords["Plasma"]['Atmospheric'] = ['atmospheric']
keywords["Plasma"]['VE'] = ['TWT', 'traveling', 'gyrotron', 'klystron']
keywords["Plasma"]['PIC'] = ['PIC ', 'particle-in-cell']
keywords["Applied"] = {}
keywords["Applied"]['RSim'] = ['geant']
keywords["Applied"]['Chemistry'] = ['silicon']

# These should probably be done just by high level
sort_categories['quant-ph'] = "Chemistry"
sort_categories['cond-mat'] = "Chemistry"
sort_categories['q-bio'] = "Chemistry"
sort_categories['cs'] = "CSE"
sort_categories['math'] = "CSE"
sort_categories['math-ph'] = "Physics"
sort_categories['data-an'] = "CSE"
sort_categories['stat'] = "CSE/ML"
sort_categories['q-fin'] = "Applied/Finance"


class PdfDownloader:
    def __init__(self, options=None):
        """Constructor does base validation and file checks"""
        self.verbose = options.verbose
        self.files = []
        self.dirs = []
        for ifile in options.files:
            if os.path.isdir(ifile):
                self.dirs.append(ifile)
            elif not os.path.exists(ifile):
                print("File not found: ", ifile)
                continue
            self.files.append(ifile)

        return

    def run(self):
        """Decide what to do depending on what was given"""
        if self.dirs:
            self.sort()
        else:
            self.download()
        return

    def sort(self):
        """Sort the pdf files in a directory"""
        start_dir = os.path.abspath(os.curdir)
        for dir in self.dirs:
            for pfile in glob.glob(dir + '/*.pdf'):
                basename = os.path.basename(pfile)
                arxiv_num = os.path.splitext(basename)[0]
                # This also write out a file in the Bibtex dir
                local_file = self.get_sort_dir(arxiv_num)
                if self.verbose:
                    print(arxiv_num, pfile, local_file)
                shutil.move(pfile, local_file)
            os.chdir(start_dir)
        return

    def download(self):
        """Go through each file and download the URL's found in them"""
        for dfile in self.files:
            with open(dfile, "r") as fh:
                for fl in fh:
                    line = fl.strip()
                    if not line.startswith("http"):
                        continue
                    else:
                        self.download_url(line)
        return

    def download_url(self, url):
        """Download a single URL"""
        # Fix arxive
        arxiv_num = url.split("/")[-1]
        pdf_url = "https://arxiv.org/pdf/" + arxiv_num + ".pdf"
        if self.verbose:
            print(arxiv_num)
        # Do automatic sorting
        local_file = self.get_sort_dir(arxiv_num)

        # If we already downloaded local file, then skip
        if os.path.exists(local_file):
            print(f"Already downloaded: {local_file}")
            return

        # Send an HTTP GET request to the URL
        response = requests.get(pdf_url)

        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Specify the local file path where you want to save the PDF
            print(local_file)

            # Open local file in binary write mode ('wb') and write PDF to it
            with open(local_file, "wb") as pdf_file:
                pdf_file.write(response.content)

            print(f"PDF downloaded and saved as '{local_file}'")
        else:
            print(f"Failed to download. Status code: {response.status_code}")
            return

    # Internal function for writing the bibtex output
    def write_bib_file(self, bib_obj, arxiv_num, local_file):
        """ See the arxiv2bib source code for how to do this"""
        bibfile = os.path.join('Bibtex', arxiv_num+".bib")
        with open(bibfile, "w") as fh:
            fh.write(f"# For {local_file}")
            fh.write(bib_obj.bibtex())
        return

    def get_sort_dir(self, arxiv_num):
        """
        Using an arxiv2bib Reference object, get the relevant info and
        automatically categorize
        Also, write out the bib info since we have it
        """
        # Use arxiv2bib to get the information
        bib = a2b.arxiv2bib([arxiv_num])
        bibobj = bib[0]
        category = bibobj._category()
        abstract = bibobj._field_text('summary')
        if self.verbose:
            print(category)

        if category.startswith('physics'):
            category = category.split('.')[1]
            if category not in sort_categories:
                category == 'physics'
        else:
            # cond-mat, CS, ...
            category = category.split('.')[0]

        if category in sort_categories:
            sort_dir = sort_categories[category]
            # Some categories are too broad
            new_sort_dir = ""
            if sort_dir in keywords:
                for kw in keywords[sort_dir]:
                    for search in keywords[sort_dir][kw]:
                        if search.lower() in abstract.lower():
                            new_sort_dir = os.path.join(sort_dir, kw)
            sort_dir = (new_sort_dir if new_sort_dir else sort_dir)

        else:
            print(f"Category not found: {category}")
            sort_dir = 'ToSort'

        local_file = os.path.join(sort_dir, arxiv_num+".pdf")
        # Do a quick write of bib file as long as we have info
        self.write_bib_file(bibobj, arxiv_num, local_file)
        return local_file


def parse_pdfdownload_args():
    """
    General arguments that control the downloading
    """
    desc = "Download a pdf file from file containing the URLs"
    desc += ", or sort files in a directory"
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument("files", type=str, nargs="+",
                        help="File(s) containing the URL")
    parser.add_argument(
        "-v", "--verbose", help="Verbose output", dest="verbose",
        action="store_true"
    )
    return parser


def main():
    """
    Parse arguments and act accordingly
    """
    parser = parse_pdfdownload_args()
    args = parser.parse_args()

    downloader = PdfDownloader(args)
    downloader.run()


if __name__ == "__main__":
    main()
