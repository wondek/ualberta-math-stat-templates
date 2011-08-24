texpreamble("\def\urltilde{\kern -.15em\lower .7ex\hbox{\~{}}\kern .04em}");


size(215.9mm,279.4mm);
real r=279.4/215.9;
pair Pbl=(0,0), Ptr=(1,r);
pair Pbr=(1,0), Ptl=(0,r);

Draw(Pbl--Pbr--Ptr--Ptl--Pbl);


// change these values to change the card dimensions
real bx0=92.1;
real by0=68.7;

// change these values to change the page margin dimensions (measured
// from lower-left corner)
real xoff0=16.4;
real yoff0=9;

// do not change these (derived values):
real bx=bx0/215.9;
real by=by0/279.4;
real xoff=xoff0/215.9;
real yoff=yoff0/279.4;


for(int i=0; i < 5; ++i) {
  for(int j=0; j <2; ++j) {
    pair bl=(j*bx+xoff,i*by+yoff);
    pair br=((j+1)*bx+xoff,i*by+yoff);
    pair tr=((j+1)*bx+xoff,(i+1)*by+yoff);
    pair tl=(j*bx+xoff,(i+1)*by+yoff);
    path b=bl--br--tr--tl--bl;
    pair ctr=0.5*(bl+tr);
    pair ctrright=0.5*(br+tr);
    pair ctrleft=0.5*(bl+tl);


    // this draws the individual card boundaries.  Comment it out when
    // you're ready to print.
    draw(b);

    // logo position: change this to change where the logo goes
    pair logopos=(0.056,0.055);

    label(graphic("logo.eps","width=1.4cm"),ctrleft+logopos);


    // text offset: change this to move the text left and right.
    real lxoffset=0.18;


    // the text
    label(minipage("{\large\bf{Malcolm Roberts}}
\smallskip
\\ Department of Mathematical and Statistical Sciences
\smallskip
\\ University of Alberta
\bigskip
\\ {\small\texttt{www.math.ualberta.ca/\urltilde{}mroberts}}
\\ {\small\texttt{mroberts{@}math.ualberta.ca}}
"
		   ,6cm),
	  (1-lxoffset)*ctr+lxoffset*ctrright);
	 
  }
}

