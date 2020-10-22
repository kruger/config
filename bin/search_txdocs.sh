#!/bin/bash

######################################################################
#
# @file    search_txdocs.sh
#
# @brief   Convert txdevdocs documents to PDFs and use Acrobat
#          to search
#
# @version $Id: search_txdocs.sh 375 2019-10-22 23:52:15Z swsides $
#
# Copyright &copy; 2015-2018, Tech-X Corporation, Boulder, CO.
# All rights reserved.
#
######################################################################

# Always nice to have
myname=`basename $0`
mydir=`dirname $myname`
mydir=`(cd $mydir; pwd -P)`
myproj=`basename $PWD`

#
# Convert docs to PDF
# Loops over directories at level where script is executed
# For each directory pptx, txt and xlsx are converted to PDFs
#
convert_docs2pdf() {

    echo "" ; ls -d */ ; echo ""
    read -p "Choose directory to convert [name, default 'all']: " subdir
    echo ""
    subdir=${subdir:-all}

    if [ $subdir == "all" ]; then
        searchDirs=(`ls -d ./*/`)
    else
        searchDirs=(`ls -d $subdir/`)
    fi

    echo ""
    echo "Converting files in directories ${searchDirs[@]}"
    echo ""

    for dirname in "${searchDirs[@]}" ; do

        echo "---------------------------------------------"
        echo "Converting files in $dirname"
        echo "---------------------------------------------"

        pptxFiles=(`find $dirname -type f -name "*.pptx"`)
        textFiles=(`find $dirname -type f -name "*.txt"`)
        xlsxFiles=(`find $dirname -type f -name "*.xlsx"`)
        docxFiles=(`find $dirname -type f -name "*.docx"`)

        allFiles=("${pptxFiles[@]}" "${textFiles[@]}" "${xlsxFiles[@]}" "${docxFiles[@]}")
        echo "  found the following files --> ${allFiles[@]}"
        echo ""

        for filename in "${allFiles[@]}"; do

            # Remove file extension from filename
            prefixName="${filename%.*}"
            pdfName="${prefixName}.pdf"

            if [ -f "$pdfName" ] && $SKIP_PDF_CONVERT_IF_FOUND; then
                echo "Found $pdfName, skipping conversion"
                echo ""
            else
                if $RUN_CONVERT_UNOCONV; then
                    echo "Converting to PDF (using unoconv) --> $filename"
                    unoconv -T 10 -f pdf $filename > search_txdocs.log 2>&1
                fi
                if $RUN_CONVERT_SOFFICE; then
                    echo "Converting to PDF (using soffice) --> $filename"
                    soffice --headless --convert-to pdf --outdir $dirname $filename
                fi
            fi
        done
        echo ""

    done

    echo ""
    echo "!!!!!! Done converting to PDF files !!!!!!"
    echo ""
}


#
# Start up Adobe Acrobat to perform search over PDF files
#
start_search() {
    echo ""
    echo "-------------------------------------------------"
    echo "Starting Adobe Acrobat to search PDFs            "
    echo "-------------------------------------------------"

    echo ""
    echo "Go to Edit->Advanced Search"
    echo ""
    sleep 2
    open "/Applications/Adobe Acrobat Reader DC.app"
}


#
# Check for Adobe acrobat on each platform
#
check_for_acrobat() {

    unameOut="$(uname -s)"
    case "${unameOut}" in

        Linux* | CYGWIN*)
            echo ""
            echo "-----------------------------------------------"
            echo "Checking for Acrobat reader on Linux/CYGWIN"
            echo ""
            echo "Not tested for linux, user will need to add by"
            echo "going to 'check_for_acrobat' method and adding"
            echo "name of linux/windows version of Acrobat"
            echo "-----------------------------------------------"
            exit
            ;;

        Darwin*)
            echo ""
            echo "-----------------------------------------------"
            echo "Checking for Acrobat reader on Mac"
            echo "-----------------------------------------------"
            if [ -d "/Applications/Adobe Acrobat Reader DC.app" ]; then
                echo "Found /Applications/Adobe Acrobat Reader DC.app"
                sleep 1
            else
                echo "Acrobat reader not found"
                echo "Install from 'https://get.adobe.com/reader'"
                echo ""
                exit
            fi
            ;;

        *)
            echo ""
            echo "-----------------------------------------------"
            echo " Platform $unameOut not recognized... exiting  "
            echo "-----------------------------------------------"
            exit
    esac
}


#
# Check for Adobe acrobat on each platform
#
check_for_unoconv() {

    unameOut="$(uname -s)"
    case "${unameOut}" in

        Linux* | Darwin*)
            echo ""
            echo "-----------------------------------------------"
            echo "Checking for file converter unoconv"

            command -v unoconv >/dev/null 2>&1 || {
                echo >&2 "  required 'unoconv' converter not found"
                echo     "  try 'brew install unoconv'"
                echo ""
                echo " and check for install of latest libreoffice"
                echo " try "
                echo "   'brew      install libreoffice libreoffice-language-pack'"
                echo " or"
                echo "   'brew cask install libreoffice libreoffice-language-pack'"
                exit 1
            }
            echo "Found 'unoconv' converter"
            echo "-----------------------------------------------"
            ;;

        CYGWIN*)
            echo ""
            echo "-----------------------------------------------"
            echo "Not supported for CYGWIN... sorry"
            echo "-----------------------------------------------"
            echo ""
            exit 1
            ;;
        *)
            echo ""
            echo "-----------------------------------------------"
            echo " Platform $unameOut not recognized... exiting  "
            echo "-----------------------------------------------"
            echo ""
            exit 1
    esac
}


#
# Check for Adobe acrobat on each platform
#
check_for_soffice() {

    unameOut="$(uname -s)"
    case "${unameOut}" in

        Linux* | Darwin*)
            echo ""
            echo "-----------------------------------------------"
            echo "Checking for file converter unoconv"

            command -v soffice >/dev/null 2>&1 || {
                echo >&2 "  required 'soffice' converter not found...try"
                echo "   'brew install libreoffice libreoffice-language-pack'"
                echo "    or"
                echo "   'brew cask install libreoffice libreoffice-language-pack'"
                exit 1
            }
            echo "Found 'soffice' converter"
            echo "-----------------------------------------------"
            ;;

        CYGWIN*)
            echo ""
            echo "-----------------------------------------------"
            echo "Not supported for CYGWIN... sorry"
            echo "-----------------------------------------------"
            echo ""
            exit 1
            ;;
        *)
            echo ""
            echo "-----------------------------------------------"
            echo " Platform $unameOut not recognized... exiting  "
            echo "-----------------------------------------------"
            echo ""
            exit 1
    esac
}



#
# Run the pptx_search.py script
#
run_python_search() {
    python pptx_search.py
}


#
# Usage/help message
#
usage() {
  cat >&2 <<EOF

Usage: $myname [options]

Options:
  -h  ..... Print this help along with notes and exit
  -u  ..... Convert documents to PDF using 'unoconv'
  -f  ..... Convert documents to PDF using 'soffice'
  -a  ..... Start platform Adobe reader
  -s  ..... Skip PDF conversion if PDF found. If this option is not specified,
            PDF conversion is forced (must be used along with the '-c' option).
            NOTE: conversion for the 'vorpal' directory takes >~ 8 mins

  -p  ..... Direct search of pptx files using python package 'pptx'

EOF
}

notes() {
  cat >&2 <<EOF

------------------
Notes:
------------------

  Searching txdevdocs relies on the advanced search feature in Adobe Acrobat Reader
  Any PDF files that are part of the repo and have been checked in, can be searched

  This script will check for presence of an Adobe Acrobat Reader version from a MacOSX
  DMG installer and the 'soffice' program for converting 'office-like' files to PDFs.

  First, the pptx, txt, xlsx and docx files in txdevdocs need to be converted to PDF files
  If you've *just* checked out txdevdocs or lots of changes have just occured, you'll
  need to convert any updated files to PDFs

  Once target files have been converted to PDFs, they can be searched in Adobe Acrobat
  Reader. Recent versions of Adobe Reader however, have been unstable and crash during
  search.

  Therefore, a pure python search has been implemented whereby the pptx (only) files
  can be searched directly. The package 'pptx-python' must be installed by a python3
  on your system.

  -------------------------------------------------------------------------------------
                                  *** CAREFUL ***
  -------------------------------------------------------------------------------------
   1. script has only been tested on Mojave OSX
   2. porting to linux should be easy... just need to check for different
      Adobe reader app name
   3. porting to windows will require major rewrite... even for cygwin
   4. Latex files are not converted to PDF. User must generate those PDFs manually

EOF
}


# -----------------------------------
# Flags
# -----------------------------------
SKIP_PDF_CONVERT_IF_FOUND=false
RUN_SEARCH=false
RUN_CONVERT_UNOCONV=false
RUN_CONVERT_SOFFICE=false
RUN_PYTHON_SEARCH=false

# Parse arguments
while getopts ":shacfup" arg; do

    case "$arg" in
        s) SKIP_PDF_CONVERT_IF_FOUND=true ;;
        a) RUN_SEARCH=true ;;
        u) RUN_CONVERT_UNOCONV=true;;
        f) RUN_CONVERT_SOFFICE=true;;
        p) RUN_PYTHON_SEARCH=true;;
        h) usage |more
           notes ; exit
           ;;
    esac

done

# ------------------------
# Run commands
# ------------------------
if $RUN_CONVERT_UNOCONV; then check_for_unoconv ; convert_docs2pdf ; exit ; fi
if $RUN_CONVERT_SOFFICE; then check_for_soffice ; convert_docs2pdf ; exit ; fi
if $RUN_SEARCH;  then check_for_acrobat ; start_search ; exit ; fi
if $RUN_PYTHON_SEARCH; then run_python_search ; exit ; fi


# Check for no args
unset name
if [ -z "$name" ]; then
    usage
fi
