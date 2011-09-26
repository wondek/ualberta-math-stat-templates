#!/bin/bash
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
