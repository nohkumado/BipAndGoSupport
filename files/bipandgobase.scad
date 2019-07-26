l = 3;
dlu = 1.4;//Breite unten
dlo = 2.62;//Breite oben
w= 32;//Länge
h= 11.3;//Max Höhe
uo = 9.3; // Höhe der Brechung
uxo = 20; // Anfang der Brechung
uxu = 25; //Ende der Brechung


module prism(l, w, h)
{
  polyhedron(
      points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
      faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
      );
}

module fillet(r, h) 
{
  translate([r / 2, r / 2, 0])

    difference() {
      cube([r + 0.01, r + 0.01, h], center = true);

      translate([r/2, r/2, 0])
        cylinder(r = r, h = h + 1, center = true, $fn=64);

    }
}

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

module frontplatte(dlu,dlo,uxu,uxo,uo,h,w)
{
  difference()
  {
    einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
    union()
    {
      difference()
      {
        translate([1,1.5,1])scale(v = [1, .9, .8]) 
        {
          difference() //untere rechte Ecke runden
          {
            einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
            translate([-.5,0,0])rotate([0,-90,0])fillet(5,2*dlo);
          }

        }
        union()
        {
          translate([-dlo,3*w/4,1]) cube([10,20,1*h/3]);
          translate([-5,23.8,2.9])rotate([0,90,0])cylinder(h=10,d=5,$fn=32);
        }
      }
      translate([-5,23.8,2.9])rotate([0,90,0])cylinder(h=10,d=2.5,$fn=32);
      translate([-5,27,0])rotate([0,90,0])cylinder(h=10,d=2.5,$fn=32);  
      translate([-5,24,2.5])cube([10,10,1]); 
    }
  }

  color("magenta") translate([-1.6,19.2,2.0])rotate([90,00,0])cylinder(h=18,d=0.88,$fn=32);
  color("magenta") translate([-2.38,19.2,9.53])rotate([90,00,0])cylinder(h=18,d=0.88,$fn=32);
}

module armhalter(dlu,dlo,uxu,uxo,uo,h,w)
{
  //translate([3,-2,25])
  //  rotate([0,180,0])prism(3,2,25); //Rechteckkurve
  difference()
  {
    union()
    {
      cube([14,4,h]); //Arm
      translate([0,0,5.212])
      minkowski()
      {
        translate([.5,0.5,0])cube([12,10,1]); //Einschiebplatte
        sphere(.2);
      }
    }
    translate([15,0,0]) einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
  }
  translate([14,0,0]) //einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
  frontplatte(dlu,dlo,uxu,uxo,uo,h,w);
}//module armhalter(dlu,dlo,uxu,uxo,uo,h,w)

/*


//translate([-3,0,30])
{ 
//translate([14,0,1.71]) einschubForm(dlu,dlo,uxu,uxo,uo,h,w);

difference()
{
ecken = [[1,-.5,0],[1,-2,25],[1,28,25],[1,28,0]];
rotat = [[0,-90,0],[0,90,0],[0,90,180],[0,-90,180]];
depth = [50,5,5,5];
union()
{
//color("blue")
for(i=[0:3]) translate(ecken[i]) rotate(rotat[i]) fillet(5,depth[i]);
translate([1.1,2.89,17])
rotate([90,0,90])
linear_extrude(2)
text("BIP & GO", size=3.6, font="Utopia", $fn=32);

}


}//difference
}//translate

 */

//  color("green")

posx = 11.1;
posy = 0;
posz = 20;
//translate([posx,posy,posz])
//einschubForm(dlu,dlo,uxu,uxo,uo,h,w);
//frontplatte(dlu,dlo,uxu,uxo,uo,h,w);
//translate([posx,posy,posz])
difference()
{
  union()
  {
    cube([3,28,25]);
    armhalter(dlu,dlo,uxu,uxo,uo,h,w);
  }
  ecken = [[1,-.6,-.7],[1,0,25],[1,28,25],[1,28,0]];
  rotat = [[0,-90,0],[0,90,0],[0,90,180],[0,-90,180]];
  depth = [50,5,5,5];
  union()
  {
    //color("blue")
    for(i=[0:3]) translate(ecken[i]) rotate(rotat[i]) fillet(5,depth[i]);
    translate([1.1,2.89,17])
      rotate([90,0,90])
      linear_extrude(2)
      text("BIP & GO", size=3.6, font="Utopia", $fn=32);

  }


}//difference

//color("green")  
//polygon(points=[[-dlu,0], [dlu,0], [dlu,w], [-dlu,w]]); 
