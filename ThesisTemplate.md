# Introduction #

This template is designed to match the requirements for theses submitted
at the University of Alberta.  It's worked for at least one thesis submission; if you have updates with new FGSR regulations, please send a patch!

The template was designed with TeXLive, and may need some modification to work with MiKTeX.



# Details #

You can compile using
```
latexmk thesis
```
or
```
latexmk -pdf thesis
```
if you want to create a PDF directly, which will set up the author name in the resulting PDF correctly.  The file convertepstopdf.sh converts all eps files in a directory to PDF and then crops them, as ps2pdf seems to make page-sized PDFs regardless of the size of the input eps/ps file.