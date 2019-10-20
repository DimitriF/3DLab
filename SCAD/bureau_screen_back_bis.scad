include <vitamine.scad>

module link_deck(){
    difference(){
        cube([75,20,20],center=true);
        cube([18,100,10],center=true);
        translate([64.1/2,0,0])rotate([90,0,0]) cylinder(d=4,h=100,center=true);
        translate([-64.1/2,0,0])rotate([90,0,0]) cylinder(d=4,h=100,center=true);
        translate([-64.1/2,5,0])rotate([90,0,0]) cylinder(d=9,h=20,center=true);
        translate([64.1/2,5,0])rotate([90,0,0]) cylinder(d=9,h=20,center=true);
        rotate([0,0,90]) cylinder(d=11,h=100,center=true);
    }
}

module link_profile(){
    for(i = [-1,1]){
        difference(){
            hull(){
                translate([30,i*(255/2-10),0])cube([20,20,20],center=true);
                translate([30,i*(287/2-10),0])rotate([0,90,0])cylinder(d=20,h=20,center=true);
            }
            translate([30,i*(255/2-10),-5])cube([21,30,20],center=true);
            translate([30,i*(255/2-10),-10])cube([21,100,20],center=true);
            translate([30,i*(255/2-10),0])cylinder(d=6,h=30,center=true);
            translate([30,i*(255/2-10),0])cylinder(d=10,h=20-2*3,center=true);
            color("red",0.5)translate([0,i*(287/2-10),0]) rotate([0,90,0]) rotate([0,0,90]) cylinder(d=11,h=1000,center=true);
        }
        
    }
}
module full_view(){
   for(i = [-1,1]){
    translate([0,i*(287/2-10),0]) rotate([0,90,0])link_deck();
    translate([20,i*(255/2-10),22])rotate([0,90,0])profile(295);
    color("red",0.5)translate([0,i*(287/2-10),0]) rotate([0,90,0]) rotate([0,0,90]) cylinder(d=13,h=1000,center=true);
    }
    link_profile();
} 
link_profile();
//full_view();