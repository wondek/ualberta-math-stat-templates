#!/bin/bash


if [ "$1" == "" ]; then
    for x in *.eps; 
    do 
	echo 
	echo $x
	echo eps2eps $x
	eps2eps $x
	echo epstopdf $x
	epstopdf $x
	pdfname=$(echo $x | sed 's/eps/pdf/g' )
	echo $pdfname
	pdfcrop $pdfname $pdfname
    done
else
    echo 
    echo $1
    echo eps2eps $1
    eps2eps $1
    echo epstopdf $1
    epstopdf $1
    pdfname=$(echo $1 | sed 's/eps/pdf/g' )
    echo $pdfname
    pdfcrop $pdfname $pdfname
fi
