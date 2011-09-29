//size(5cm,5cm);

label(graphic("UA-1C-SOLID.eps"),(0,0));
layer();
pair L=(0,0);
pair dx=(234,0), dy=(0,58);
path p=(L-dx-dy)--(L+dx-dy)--(L+dx+dy)--(L-dx+dy)--cycle;

dot((-1,-1),invisible);
dot((1,1),invisible);

draw(p,invisible);
clip(p);

