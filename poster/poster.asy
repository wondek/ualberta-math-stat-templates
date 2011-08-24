import fontsize;
import flowchart;
import graph;
//usepackage("mathdef,citebracket");
usepackage("mathdef");
settings.twice=true;



//////  Content  //////

// Title tex
string titletex="Title";
string titletex2=
  "A Scientific Poster in Asymptote";
string authortex="Author 1, Institution 1; Author 2, Institution 2";

// Column one: sizes and text.
real[] col1frac;
string[] tex0=new string[3];//TODO: make [3] a variable.

// Column 1 row 1 size
col1frac[0]=0.25; 
// Column 1 row 1 tex
tex0[0]="
{\bf Setting the Stage}

Box 1
";

// Column 1 row 2 size
col1frac[1]=0.15; // change this to get a different height for box 2.
// Column 1 row 2 tex
tex0[1]="
{\bf Questions}

Box 2
";

// this height is automatically determined from what's left over.
// Column 2 row 1 tex
tex0[2]=
"
{\bf Header}

Box 3
";


//bottom-left text
string texbl=
"
{\bf Header}

Box 5
";

//bottom-right text
string texbr=
"
{\bf Header}

Box 6
";

// Column 1 row 3 tex
string tex21="
{\bf Header}

The big box
";


//////  Setup  //////

// Paper size information: A0 paper size
real A0h=841mm,A0w=1189mm;
size(A0w,A0h);

defaultpen(deepblue+fontsize(24));

real boxopac=0.95; // opacity for background image

// title settings
real titlew=600mm, titleh=90mm;
real tspace=20mm, toffset=-5mm;
real tspace2=20mm;
pen titlebpen=invisible;//paleblue+opacity(boxopac);
pen titlepen=black+fontsize(110), authorpen=black+fontsize(50);
pen titlepen2=black+fontsize(45);
real tmarg=15mm;

// column settings
int ncols=3;
real marg=10mm, boxspace=5mm, boxmarg=marg+boxspace;
real colw= (A0w-(ncols-1)*(2*boxmarg) - 4*(ncols-1)*marg)/ncols;
real colh=650mm;
pen colpen=black+fontsize(36);
pen boxpen=rgb("E8D6E5")+opacity(boxopac);
pen boxborder=invisible;
pen roundpen=paleblue+linewidth(10);


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

// Functions for fitting boxes together
void fitvert(picture picout, picture[] picin) {
  if(picin.length==1)
    picout=picin[0];
  if(picin.length==2){
    add(picout,picin[0].fit(),(0,boxspace),N,FillDraw(0,0,invisible));
    add(picout,picin[1].fit(),(0,-boxspace),S,FillDraw(0,0,invisible));
  }
  if(picin.length==3) {
    picture pica;
    add(pica,picin[0].fit(),(0,boxspace),N,FillDraw(0,0,invisible));
    add(pica,picin[1].fit(),(0,-boxspace),S,FillDraw(0,0,invisible));
    add(picout,pica.fit(),(0,boxspace),N,FillDraw(0,0,invisible));
    add(picout,picin[2].fit(),(0,-boxspace),S,FillDraw(0,0,invisible));
  }
  //FIXME: figure out the other cases
}

void fithorizont(picture picout, picture[] picin) {

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

nboxes[0]=3;
picture[] pic0=new picture[nboxes[0]];

col1frac[nboxes[0]-1]=1-sum(col1frac);
real b1diff=(nboxes[0]-1)*marg;

for(int i=0; i < pic0.length; ++i) {
  pic0[i] = new picture;
  drawbox(tex0[i],pic0[i],colw,colh*col1frac[i]-b1diff);
}
fitvert(pic1,pic0);

real topfrac=0.5, bottomfrac=1-topfrac;
picture picwide;
drawbox(tex21,picwide,2*colw+2*boxmarg+boxspace,
        colh*topfrac-boxmarg-boxspace);
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
