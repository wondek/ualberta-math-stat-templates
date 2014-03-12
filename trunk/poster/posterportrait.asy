import fontsize;
import flowchart;
import graph;
//usepackage("mathdef,citebracket");
usepackage("mathdef");
usepackage("multirow");
settings.twice=true;



//////  Content  //////



// Title tex
string titletex="Tile of Poster";
string titletex2="Author, University";
string authortex="Maybe a web site or something here.";

int nrowcol1=4;

// Column one: sizes and text.
real[] col1frac = new real[nrowcol1];
for(int i=0; i < nrowcol1; ++i) {
  col1frac[i]=1.0/(real) nrowcol1;
}
string[] tex0=new string[nrowcol1];

// Column 1 row 1 size
col1frac[0]=0.23; 
// Column 1 row 1 tex
tex0[0]="
\begin{center}
{\bf First Column First Box}
\end{center}

And some stuff.
";

// Column 1 row 2 size
col1frac[1]=0.28;

// Column 1 row 2 tex
tex0[1]="
\begin{center}
{\bf First Column Second Box}
\end{center}

And some more stuff.
";

col1frac[2]=0.27;
// Column 1 row 3 tex
tex0[2]="
\begin{center}
{\bf First Column Third Box}
\end{center}

Boy, more stuff?
";

// Column 1 row 4 tex
tex0[3]="
\begin{center}
{\bf First Column Fourth Box}
\end{center}

You don't have to have this many boxes in the first column if you don't want.
";

//bottom-left text
string texbl=
"
\begin{center}
{\bf Lower-Left Box}
\end{center}

Drive that point home.

";

//bottom-right text
string texbr=
"
\begin{center}
{\bf Conclusion}
\end{center}

Reference are added manually.
										";

// Column 1 row 3 tex
string tex21="
\begin{center}
{\bf My Goodness What A Very Large Box You Have}
\end{center}

One could put quite a lot of stuff in this box, couldn't one.

% 
%\begin{center}
%\includegraphics[width=70cm]{nameoffigure}
%\end{center}


";


//////  Setup  //////

// Paper size information: A0 paper size
real A0h=1189mm,A0w=841mm;
size(A0w,A0h);

// Uncomment the following two lines in order to include a background image
//label(graphic("background","height="+(string)(A0h)+"pt"), (0,0));
//layer();

defaultpen(deepblue+fontsize(24));

real boxopac=0.8; // opacity for background image

// title settings
real titlew=600mm, titleh=90mm;
real tspace=20mm, toffset=-5mm;
real tspace2=20mm;
pen titlebpen=invisible;//paleblue+opacity(boxopac);
pen titlepen=black+fontsize(110), authorpen=black+fontsize(50);
pen titlepen2=black+fontsize(50);
real tmarg=15mm;

// column settings
int ncols=3;
real marg=10mm, boxspace=5mm, boxmarg=marg+boxspace;
real colw= (A0w-(ncols-1)*(2*boxmarg) - 4*(ncols-1)*marg)/ncols;
real colh=900mm; // height of poster columns
pen colpen=black+fontsize(36);
pen boxpen=rgb("FFDB05")+opacity(boxopac); // yellow
pen boxborder=invisible;
pen roundpen=rgb("007C41")+linewidth(10); // green

//////  Formatting  //////

// function for sub pictures
real picw, pich;
path picbox, roundbox;
real rwo, rho,rwi, rhi;
void setpic(picture pic, real w, real h) {
  picw=w;
  pich=h;
  picbox=(-w/2,h/2)--(w/2,h/2)--(w/2,-h/2)--(-w/2,-h/2)--cycle;
  rwi=w/2;
  rwo=rwi+marg;
  rhi=0.5*h;
  rho=rhi+marg;
  roundbox=(-rwo,rhi)::(-rwi,rho)---(rwi,rho)::(rwo,rhi)---(rwo,-rhi)
              ::(rwi,-rho)--(-rwi,-rho)::(-rwo,-rhi)---cycle;
  xlimits(pic,-w/2,w/2);
  ylimits(pic,-h/2,h/2);
  draw(pic,picbox,boxborder);
  crop(pic);
};

// Function for drawing boxes
void drawbox(string tex, picture pic, real w, real h){
  setpic(pic,w,h);
  label(pic,minipage(tex,w),(0,0),colpen);
  clip(pic,picbox);
  fill(pic,roundbox,boxpen);
  draw(pic,roundbox,roundpen);
  draw(pic,picbox,boxborder);
}

void addsubpic(picture pic, picture pica, picture picb) {
  add(pic,pica.fit(),(0,boxspace),N,FillDraw(0,0,invisible));
  add(pic,picb.fit(),(0,-boxspace),S,FillDraw(0,0,invisible));
}

// Functions for fitting boxes together
void fitvert(picture picout, picture[] picin) {
  if(picin.length==1) {
    picout=picin[0];
    return;
  }
  if(picin.length==2) {
    addsubpic(picout,picin[0],picin[1]);
    return;
  }

// make temporary pictures for fitting and adding
  picture[] pictemp=new picture[picin.length-2];
  for(int i=0; i < pictemp.length; ++i) {
    pictemp[i]=new picture;
  }

  if(picin.length==3) {
    addsubpic(pictemp[0],picin[0],picin[1]);
    addsubpic(picout,pictemp[0],picin[2]);
    return;
  }

  addsubpic(pictemp[0],picin[0],picin[1]);
  for(int i=1; i < pictemp.length; ++i) {
    addsubpic(pictemp[i],pictemp[i-1],picin[i+1]);
  }
  addsubpic(picout,pictemp[1],picin[picin.length-1]);
}


// Using the functions to draw the parts of the poster

// Title
picture pict;
{
  real colw0=colw;
  colw=titlew;
  setpic(pict,titlew,titleh);
  label(pict,titletex,(0,toffset+1.5*tspace),titlepen);
  label(pict,titletex2,(0,toffset+0.0*tspace),titlepen2);
  label(pict,authortex,(0,toffset-1*tspace2),authorpen);
    
  // logos
  real offset=400mm;
//  label(pict,graphic("uofa.eps","height=6cm"),(-offset,0));
//  label(pict,graphic("uofa.eps","height=6cm"),(offset,0));
  clip(pict,picbox);
  fill(pict,roundbox,boxpen);
  draw(pict,roundbox,roundpen);
  draw(pict,picbox,boxborder);
  colw=colw0;
}



// variables for columns
int[] nboxes;

// Column 1
picture pic1;

nboxes[0]=nrowcol1;
picture[] pic0=new picture[nboxes[0]];

col1frac[nboxes[0]-1]=1-sum(col1frac[0:nrowcol1-1])+0.04; // FIXME: kludge
real b1diff=(nboxes[0]-1)*marg;

for(int i=0; i < pic0.length; ++i) {
  pic0[i] = new picture;
  drawbox(tex0[i],pic0[i],colw,colh*col1frac[i]-b1diff);
}
fitvert(pic1,pic0);

real topfrac=0.5, bottomfrac=1-topfrac;
picture picwide;
drawbox(tex21,picwide,2*colw+2*boxmarg+boxspace,
        colh*topfrac-0.5*boxmarg-0.5*boxspace);
picture picbl;
drawbox(texbl,picbl,colw,colh*bottomfrac-boxspace);
picture picbr;
drawbox(texbr,picbr,colw,colh*bottomfrac-boxspace);

// Fit all the pics together
{
  picture pica,picb,picc,picd;
  add(pica,picbr.fit(),(0,0),boxspace*E);
  add(pica,picbl.fit(),(0,0),boxspace*W);

  add(picb,picwide.fit(),(0,0),boxspace*N);
  add(picb,pica.fit(),(0,0),boxspace*S);

  add(picc,picb.fit(),(0,0),boxspace*E);
  add(picc,pic1.fit(),(0,0),boxspace*W);

  add(picd,picc.fit(),(0,0),tmarg*S);
  add(picd,pict.fit(),(0,0),tmarg*N);

  add(picd.fit(),(0,0),(0,0));
   
  
}

path boundary=
  (-A0w/2,-A0h/2)--(A0w/2,-A0h/2)--(A0w/2,A0h/2)--(-A0w/2,A0h/2)--cycle;
draw(boundary,black);
clip(boundary);
