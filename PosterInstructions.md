#Instructions for using the poster template.

# Instructions for using the poster template #

The poster template uses Asymptote, which uses a TeX/LaTeX back-end.

If you have figures in ps/eps format, you can compile the poster using the command
```
asy -f pdf poster.asy
```
If you have any figures in any other formats, you must use pdflatex:
```
asy -f pdf -tex pdflatex poster.asy
```
which will also convert the ps/eps files to pdf.  These may need to be cropped using pdfcrop.

For printing purposes, you may  need to rotate the resulting pdf, which can be done with pdftk, using the command
```
pdftk poster.pdf cat 1-endE  output rot.pdf
```