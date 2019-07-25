l = 3;
dlu = 1.4;
dlo = 2.9;
w= 30;
h= 11.5;
uo = 9;
uxo = 25;
uxu = 27;

module einschubForm(untereBr,obereBr,absend,absanf,abshoehe,hoehe,breite)
{
  obVerjBreite = (obereBr-untereBr)*abshoehe/hoehe+untereBr;
  polyhedron(
      points=[[-untereBr,0,0], [untereBr,0,0], [untereBr,breite,0], [-untereBr,breite,0], //unteres Rechteck 
      [-obereBr,0,hoehe],[obereBr,0,hoehe], [obVerjBreite,breite,abshoehe],[-obVerjBreite,breite,abshoehe]    //oberes Rechteck
      ,[-obVerjBreite,absanf,hoehe], [-obVerjBreite,absend, abshoehe], [obVerjBreite,absend, abshoehe], [obVerjBreite,absanf,hoehe] //Absenkung
      ,[-untereBr,absanf,0], [-untereBr,absend, 0], [untereBr,absend, 0], [untereBr,absanf,0]
      ],  

      faces=[
      [0,1,2,3], //unten
      [5,1,0,4], //stirn links
      [1,5,11,10,6,2], //hinten
      [2,6,7,3], //stirn rechts 
      [0,3,7,9,8,4], //vorne
      [4,8,11,5], [8,9,10,11], [9,7,6,10]  //oben
      ]
      );
}

posx = 11.1;
posy = 0;
posz = 1.71;
translate([posx,posy,posz])
{
  difference()
  {
    einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
    color("blue") translate([1,1.5,1])scale(v = [1, .9, .8]) einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
  }
}
