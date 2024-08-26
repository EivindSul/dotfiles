#!/usr/bin/env bash

# TODO: Make content in report comform to the name passed to this script.

if [ -z $1 ] ; then
    echo "You need to provide a name for the folder."
    exit 1
fi

SAMPLE_DIR=$HOME/Documents/skole/report-sample

if [ ! -d $HOME/Documents/skole/report-sample ] ; then 
    echo "Report sample not found at $SAMPLE_DIR, aborting."
    exit 1
fi

REPORT_PATH=$(pwd)/$1

if [ -e $REPORT_PATH ] ; then
    echo "File or folder already exists at $REPORT_PATH. Aborting."
    exit 1
fi

cp -r $SAMPLE_DIR $REPORT_PATH || exit 1

if [ ! -d $REPORT_PATH ] ; then
    echo "Something went wrong and the report has not been created."
    exit 1
else
    echo "Made report directory at $REPORT_PATH."
    exit 0
fi
