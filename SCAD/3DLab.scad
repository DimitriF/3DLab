include <vitamine.scad>
nema14_z = 36;
nema_axe_h = 22;

rabio=0.75;

// Position, may be in the full view more
//X = $t*100-50;
//Y = ($t*100-50)*2;

Y_axis_shift_X = 0;
// Dimension
X_dim = 205+50; // course: 90 + 50 obligatory; lost: X
Y_dim = 245+50; // course: 90 + 50 obligatory lost: Y
Z_dim = 250;
X=0;
Y=50;
Z=120;
prof_type = 1; // I 20 
prof_dim = 20;
milling_thick = 10;
milling_thick_motor = 13;
rod_smooth_d = 8;
rod_smooth_Y_h = Y_dim- prof_dim*2;
//rod_smooth_X_h = X_dim- prof_dim*2; // with rod inside profiles
rod_smooth_X_h = X_dim;//- prof_dim*2;
// prof
rod_Z_h = 195;
full_prof = false;
Y_dim_min = 2;//5 for high, 2 for low
tr8_nut_inside_A = 180; //put to 180 to see it inside, 0 outside
tr8_nut_inside_h = tr8_nut_h2;//put to tr8_nut_h2 to see it inside, 0 outside


prof_X_gap = X_dim/2 - prof_dim/2; //117.5
prof_Y_gap = Y_dim/2 - prof_dim/2;
prof_Z_gap_Y = -95;//prof_Y_gap - 100 - 50;
prof_verticale_gap_1 = prof_dim/2;
prof_verticale_gap_2 = Z_dim-prof_dim/2;
profs_X = X_dim- prof_dim*2;
profs_Y = Y_dim- prof_dim*2;
profs_Z = Z_dim- prof_dim*2;
//profs_diag = sqrt(2)*profs_Z;

// Y_axis, 
rod_smooth_Y_gap_X = rod_smooth_d*2.5+nema14_xy/2;
motor_Y_gap_X = 0;
motor_Y_gap_Y = -prof_Y_gap+nema14_xy/2+prof_dim/2;
motor_Y_gap_Z = -nema_axe_h/2+prof_dim+milling_thick;
623_Y_gap_Z = motor_Y_gap_Z-10;
623_Y_gap_Y = prof_Y_gap-prof_dim;
rod_smooth_Y_gap_Z = -nema_axe_h/2+prof_dim+milling_thick-5;
motor_Y_gap_Z_real = nema_axe_h/2-milling_thick;
endstop_Y_Z = prof_dim+endstop_z/2+4;
endstop_Y_Y = Y_dim/2-prof_dim+endstop_x/2+10;
endstop_Y_X = 66;

Y_motor_Y_gap = -prof_Y_gap+prof_dim/2+milling_thick/2;
milling_thick_Y_motor = nema14_xy - prof_dim-2;

// Y_moving
Y_moving_thick=10;
Y_moving_X = 170;
Y_moving_Y=110;
Y_moving_top_Z = rod_smooth_Y_gap_Z+lm8uu_OD/2+Y_moving_thick/2*Y_dim_min; // change Y_dim_min at begining to get higher plate level

// X_axis
// motor position, from 2020:
// delrin_gap_X + name_xy/2 - X_dim/2 = 26.15
motor_X_gap_X = prof_X_gap+delrin_X/2+nema_xy/2+1+15;
motor_X_gap_Y = prof_Z_gap_Y+10+nema_xy/2+delrin_Z/2+nema_axe_h/2;
motor_X_gap_Z = Z_dim-prof_dim/2-45;
rod_smooth_X_gap_X = 0;
rod_smooth_X_gap_Y = motor_X_gap_Y; // in case of rod on the profile
rod_smooth_X_gap_Z_bis = 45/2;
delrin_gap_X = prof_X_gap+15; //132.5
delrin_gap_Z = -25;
delrin_gap_Y = prof_Z_gap_Y+10+nema_xy/2;
623_X_gap_Z = motor_X_gap_Z;
623_X_gap_X = -delrin_gap_X+15;
623_X_gap_Y = motor_X_gap_Y;

// Z_axis
motor_Z_gap_X = delrin_gap_X;
motor_Z_gap_Y = delrin_gap_Y;
motor_Z_gap_Z = Z_dim-nema_axe_h/2+10;
rod_smooth_Z_gap_X = motor_Z_gap_X;
rod_smooth_Z_gap_Y = motor_X_gap_Y+15; // in case of rod on the profile
rod_smooth_Z_gap_Z = 21;
M3_endstop_Z_X = X_dim/2+10+endstop_z/2+5+10;
endstop_Z_Z = 20+endstop_x/2;
endstop_Z_Y = prof_Z_gap_Y+50;
endstop_Z_screw_Y = endstop_Z_Y+10;
endstop_X_Z = 8;
endstop_X_Y = rod_smooth_Z_gap_Y-4;
endstop_X_X = prof_X_gap-4;


module profs(){
    union(){
        for(i = [-1,1]){
                translate([-profs_X/2 ,i*prof_Y_gap,prof_dim/2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X
                translate([i*prof_X_gap,-profs_Y/2 ,prof_dim/2]) rotate([-90,0,0]) profile(length= profs_Y ,type=prof_type); // Y bottom
            
            
            translate([i*prof_X_gap,prof_Z_gap_Y ,prof_dim]) profile(length= profs_Z ,type=prof_type); // Z middle
            for(j = [-1,1]){
                    color("green")translate([i*prof_X_gap,j*prof_Y_gap,prof_dim/2]) cube([20,20,20],center=true); //green bottom
            }
        }
    }
    
        translate([-profs_X/2 ,prof_Z_gap_Y,prof_verticale_gap_2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X top middle
        for(j = [-1,1]){
            color("green")translate([j*prof_X_gap,prof_Z_gap_Y,prof_verticale_gap_2]) cube([20,20,20],center=true); //green top middle
        }
}

module feet(){
	for(i = [-1,1]){for(j = [-1,1]){
		difference(){
			translate([i*prof_X_gap,j*prof_X_gap,-60/2]) cube([20,20,60],center=true);
			translate([i*prof_X_gap,j*prof_X_gap,-60/2-5]) cylinder(h=60,d=12,center=true);
			translate([i*prof_X_gap,j*prof_X_gap,-60/2+5]) cylinder(h=60,d=6,center=true);
		}
	}}
}

module Y_belt(){
    color("black")difference(){
        hull(){
            translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD+rabio,h=6,center=true);
            translate([0,motor_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD+rabio,h=6,center=true);
        }
         hull(){
            translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD-rabio,h=7,center=true);
            translate([0,motor_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD-rabio,h=7,center=true);
        }
    }
}
module Y_M3s(rabio=0,Y=0){
    color("green")union(){
        
        translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=3+rabio,h=30+rabio,center=true);//62.3
        // beld holder
        translate([3,Y+lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10]) cylinder(d=3+rabio,h=30+rabio,center=true);
        translate([3,Y-lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10]) cylinder(d=3+rabio,h=30+rabio,center=true);
        translate([3,Y+lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20]) cylinder(d=7+rabio,h=10+rabio,center=true);
        translate([3,Y-lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20]) cylinder(d=7+rabio,h=10+rabio,center=true);//Ymoving side
        translate([3,Y+lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20-32]) cylinder(d=7,h=4,$fn=6,center=true);//Y belt side
        translate([3,Y-lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20-32]) cylinder(d=7,h=4,$fn=6,center=true);//Y belt side
        
    }
}
module Y_rods(rabio=0){
    for(i = [-1,1]){
        translate([i*rod_smooth_Y_gap_X,0,rod_smooth_Y_gap_Z]) rotate([90,0,0]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_Y_h+rabio,center=true);// Y_rod
    }
}
module Y_axis(X=0,Y=0,Z=0){
    color("pink")translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z_real]) rotate([0,0,0]) nema17();
    Y_rods();
    % translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z]) rotate([0,0,0])gt2_pulley();
    //color("yellow") translate([motor_Y_gap_X,Y-5,motor_Y_gap_Z]) rotate([-90,0,0]) translate([0,0,0]) rotate([0,0,0]) tr8_nut();
    for(i = [-1,1]){
        for(j = [-1,1]){
            color("pink")translate([i*rod_smooth_Y_gap_X,j*housing_lm8uu_L/2+Y,rod_smooth_Y_gap_Z]) rotate([90,0,0]) housing_lm8uu();
        }
    }
    translate([endstop_Y_X,endstop_Y_Y,endstop_Y_Z]) rotate([180,180,90]) endstop();
    Y_belt();
    Y_moving_spring(Y=Y,screw=false);
    Y_glass(Y=Y);
    
Y_glass_holder(Y=Y);
}
module Y_endstop_holder(){
	difference(){
		color("gold")union(){
			//translate([endstop_Y_X,Y_dim/2-1-prof_dim,prof_dim/2]) cube([endstop_y,2,prof_dim],center=true);//body
			translate([endstop_Y_X-endstop_y/6,endstop_Y_Y,20+2]) cube([endstop_y*0.66,endstop_x,4],center=true);//link
			translate([endstop_Y_X-endstop_y/6,Y_dim/2+2,10+2]) cube([endstop_y*0.66,2,20+4],center=true);
		}
		union(){
			M5s();
			translate([endstop_Y_X,endstop_Y_Y,endstop_Y_Z]) rotate([180,180,90]) endstop_neg();//endstop_neg();
		}
	}
}

module Y_motor(){
    color("gold")difference(){
        union(){
            translate([0,-prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2-milling_thick/2]) cube([rod_smooth_Y_gap_X*2+15,milling_thick,prof_dim+milling_thick],center=true);
            translate([0,motor_Y_gap_Y,-milling_thick/2]) cube([nema_xy,nema_xy,milling_thick],center=true);
            }
        M5s();
        translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z_real]) rotate([0,0,0]) nema17_neg(rabio=rabio);
        translate([motor_Y_gap_X,motor_Y_gap_Y,-rabio]) union(){ // special to screw the head
            for(i = [-1,1]){for(j = [-1,1]){
                translate([i*nema_vis_space,j*nema_vis_space,0]) cylinder(h=23+rabio,d=6+rabio,center=false);
            }}
        }
        Y_rods(rabio=rabio);
    }
}

module Y_end(){
    color("gold")difference(){
        union(){
            translate([0,prof_Y_gap-prof_dim/2-milling_thick/2,prof_dim/2]) cube([rod_smooth_Y_gap_X*2+15,milling_thick,prof_dim],center=true);
            translate([0,prof_Y_gap-prof_dim/2-milling_thick,prof_dim/2]) cube([nema_xy/2,milling_thick*2,prof_dim],center=true);
            }
        M5s();
        Y_rods(rabio=rabio);
        translate([0,prof_Y_gap-prof_dim/2-milling_thick,623_Y_gap_Z]) cube([623zz_OD*1.5,milling_thick*3,8],center=true);
        Y_M3s(Y=Y,rabio=rabio);
    }
}


module M4_Y_moving(rabio=rabio,nut=true){
    translate([0,0,rabio/2]) union(){
        rotate([0,180,0])cylinder(d=8+rabio,h=Y_moving_thick/2+rabio);
        if(nut){
            rotate([0,180,0])cylinder(d=4+rabio,h=Y_moving_thick*5);
        }
    }
}
module Y_belt_holder(Y=0){
    color("gold")difference(){
        hull(){
            translate([4,Y,623_Y_gap_Z-6])cube([14,30,4],center=true);
            translate([4,Y,rod_smooth_Y_gap_Z-1/2+housing_lm8uu_H/2])cube([14,30,1],center=true);
        }
        translate([3,Y,623_Y_gap_Z])cube([7,30+rabio,7],center=true);
        
        Y_M3s(Y=Y,rabio=rabio);
    }
}
module M5_Y_moving(rabio=rabio,nut=true){
    translate([0,0,rabio/2]) union(){
        rotate([0,180,0])cylinder(d=10+rabio,h=Y_moving_thick/2+rabio);
        if(nut){
            rotate([0,180,0])cylinder(d=5+rabio,h=Y_moving_thick*5);
        }
    }
}
module Y_moving_spring(Y=0,screw=true){
    for(i = [-1,1]){
        for(j = [-1,1]){
            translate([i*(Y_moving_X-10)/2,j*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2]) cylinder(d=8,h=Y_moving_thick,center=true);//spring
            if(screw){
                translate([i*(Y_moving_X-10)/2,j*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2]) cylinder(d=3.5,h=200,center=true);//M3
                translate([i*(Y_moving_X-10)/2,j*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+housing_lm8uu_H/2]) cylinder(d=8,h=4,$fn=6,center=true);//m3 nut
                translate([i*(Y_moving_X-10)/2,j*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+12.5]) cylinder(d=8,h=6,center=true);//m3 head
            }
            
        }
    }
}

module Y_moving(X=0,Y=0,Z=0){
    difference(){
        color("gold") union(){
            translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick/2+housing_lm8uu_H/2]) cube([Y_moving_X,Y_moving_Y,Y_moving_thick],center=true);
        }
        union(){
            for(i = [-1,1]){
                for(j = [-1,1]){
                    color("pink")translate([i*rod_smooth_Y_gap_X,j*housing_lm8uu_L/2+Y,rod_smooth_Y_gap_Z]) rotate([90,0,0]) housing_lm8uu_neg(rabio=rabio,h=Y_moving_thick);
                    
                   translate([i*rod_smooth_Y_gap_X,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2]) cube([lm8uu_OD,housing_lm8uu_L*1.6,30],center=true); // cube neg in housing
                }
            }
            Y_moving_spring(Y=Y);
            Y_M3s(Y=Y,rabio=rabio);
        }
    }
}
//Y_moving_spring();
module Y_plate(X=0,Y=0,Z=0){
    difference(){
        color("gold") union(){
            translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+10]) cube([Y_moving_X,Y_moving_Y,5],center=true);
        }
        union(){
            for(i = [-1,1]){
                for(j = [-1,1]){
                    color("pink")translate([i*rod_smooth_Y_gap_X,j*housing_lm8uu_L/2+Y,rod_smooth_Y_gap_Z]) rotate([90,0,0]) housing_lm8uu_neg(rabio=rabio,h=Y_moving_thick);
                    
                }
            }
            Y_moving_spring(Y=Y);
        }
    }
}
module Y_glass(X=0,Y=0,Z=0){
    color("blue",0.5) union(){
        translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+10+5/2+3.5/2]) cube([153,153,3.5],center=true);
    }
}
module Y_glass_holder(X=0,Y=0,Z=0){
    difference(){
        translate([1*(Y_moving_X-10)/2,1*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+12.5-1]) cube([20,20,13],center=true);
        translate([1*(Y_moving_X-10)/2-12,-12+1*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+12.5]) rotate([0,0,45])cube([20,20,16],center=true);//45degree cutoff
        
        translate([1*(Y_moving_X-10)/2,1*(Y_moving_Y-10)/2+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+12.5]) cylinder(d=9,h=100,center=true); // M3 and srping
        translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+10+5/2+3.5/2]) scale([1.01,1.01,1.005])cube([153.1,151,3.51],center=true);//Y_glass(Y=Y);
        translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2+10]) scale([1.01,1.01,1.01])cube([Y_moving_X,Y_moving_Y,5],center=true);//Y_plate(Y=Y);
    }
        
}

module X_belt(hole=false,Z=150){
   translate([0,0,Z])  if(!hole){
        color("black")difference(){
            hull(){
                translate([623_X_gap_X,623_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD+rabio,h=6,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD+rabio,h=6,center=true);
            }
             hull(){
                translate([623_X_gap_X,623_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD-rabio,h=7,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD-rabio,h=7,center=true);
            }
        }
    }else{
        hull(){
                translate([623_X_gap_X*2,623_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD*1.5,h=11,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,0]) rotate([-90,0,0])cylinder(d=623zz_OD*1.5,h=11,center=true);
            }
    }
}

module X_axis(X=0,Y=0,Z=150){
    X_belt(hole=false,Z=Z);
    for(i = [-1,1]){
        translate([0,rod_smooth_X_gap_Y,Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d,h=rod_smooth_X_h,center=true);// X smooth
        translate([i*delrin_gap_X,delrin_gap_Y,Z+delrin_gap_Z]) rotate([-90,0,0]) delrin();
    }
    color("pink") translate([623_X_gap_X,623_X_gap_Y,Z]) rotate([-90,0,0])623zz();
    color("pink")translate([motor_X_gap_X,motor_X_gap_Y,Z]) rotate([-90,0,0]) nema17();
    translate([X,rod_smooth_X_gap_Y+16.5/2,Z]) rotate([90,0,0]) import("i3rework_Xcarriage.stl");
    //translate([-120,rod_smooth_X_gap_Y+15,Z+30]) rotate([0,180,270]) import("MK2_x-end-idler.stl");
   //% translate([120,rod_smooth_X_gap_Y+15,Z+30]) rotate([0,180,270]) import("MK2_x-end-motor.stl");
    color("green") translate([X,motor_X_gap_Y+10,Z+23]) rotate([90,0,180]) import("Bowden_carriage.stl");
    color("green") translate([X,motor_X_gap_Y+60,Z+1.5+23]) rotate([90,0,0]) import("Bowden_carriage_clamp_FanMount.stl");
    color("red") translate([X-32,motor_X_gap_Y+30,Z-62+23]) rotate([90,0,90]) import("E3D_Volcano_1.75mm_0.8mm_Hotend_Assembly_fixed.STL");
		color("green") translate([endstop_X_X,endstop_X_Y,Z+endstop_X_Z]) rotate([90,0,180]) endstop();
    difference(){
       // color("blue") translate([X-17.5,motor_X_gap_Y+47.5,Z-20]) cube([15,30,30],center=true);
    }
    
   //color("blue") translate([X-17.5-30,motor_X_gap_Y+47.5,Z-20-20]) rotate([0,45,0])cube([10,30,30],center=true);
    
}
        
module fan_cooler(X=0,Y=0,Z=0){
    color("gold") difference(){
        union(){            
            hull(){
                translate([X-17.5-30,motor_X_gap_Y+47.5,Z-20-20]) rotate([0,45,0])translate([6,0,0])cube([1,30,30],center=true);// fan side                
                translate([X-12,motor_X_gap_Y+47.5,Z-60]) cube([5,10,1],center=true);//nozzle side
            }
            translate([X-17.5-30,motor_X_gap_Y+47.5,Z-20-20]) rotate([0,45,0])translate([6+2,0,17])cube([5,5,7],center=true);//top_fan link
        }
        hull(){
                //translate([X-17.5-30,motor_X_gap_Y+47.5,Z-20-20]) rotate([0,45,0])translate([6,0,0])cube([2,26,26],center=true);// fan side                
                //translate([X-12,motor_X_gap_Y+47.5,Z-60]) cube([3,5,1.1],center=true);//nozzle side
            }
            //translate([X-17.5-12,motor_X_gap_Y+47.5,Z-20-13]) rotate([90,0,0])cylinder(d=3.5,h=100,center=true);//top_fan link
        
    }
}

module X_motor(Z=150){
	color("gold",1) difference(){
		union(){
			translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+5,Z+4]) cube([nema_xy+3,10,nema_xy+5+2],center=true);
			translate([delrin_gap_X,rod_smooth_X_gap_Y,Z-5]) cube([delrin_X,nema_axe_h,nema_xy+25],center=true);
			translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,Z+2.5]) cylinder(d=lm8uu_OD+4,h=nema_xy+10,center=true);//lm8uu
			hull(){ // z endstop screw hull
				translate([M3_endstop_Z_X,endstop_Z_screw_Y,Z-nema_xy/2-15]) cylinder(d=10,h=3,center=true);
				translate([M3_endstop_Z_X-10,endstop_Z_screw_Y-10,Z-nema_xy/2-15+15]) cylinder(d=10,h=3,center=true);
			}
			translate([endstop_X_X,endstop_X_Y-endstop_z/2-1,Z+2.5]) cube([endstop_x,2,(nema_xy+10)],center=true);
		}
		translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+5,Z])  rotate([-90,0,0]) nema17_neg();
		translate([motor_X_gap_X+nema_xy/3,motor_X_gap_Y-nema_axe_h/2+5,Z+4-nema_xy/2.5]) cube([nema_xy+3,11,nema_xy+5+2],center=true);
		for(i = [-1,1]){
			translate([0,rod_smooth_X_gap_Y,Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d+0.5,h=rod_smooth_X_h,center=true);// X smooth
			translate([i*delrin_gap_X,delrin_gap_Y,Z+delrin_gap_Z]) rotate([-90,0,0]) delrin_neg();
		}
		X_belt(hole=true,Z=Z);//belt
		translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,Z]) cylinder(d=lm8uu_OD,h=lm8uu_z*4,center=true);//lm8uu
		translate([motor_Z_gap_X,motor_Z_gap_Y,Z_dim]) rotate([180,0,0]) cylinder(d=coupler_d+4,h=Z_dim-Z+5);
		translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y+5,Z+2.5]) cube([2,lm8uu_OD+5,200],center=true);//lm8uu line cut
		translate([M3_endstop_Z_X,endstop_Z_screw_Y,Z-nema_xy/2-15]) cylinder(d=3.4,h=30,center=true); // z endstop screw
		translate([endstop_X_X,endstop_X_Y,Z+endstop_X_Z]) rotate([90,0,180]) endstop_neg(simple=true);
		translate([endstop_X_X,endstop_X_Y,Z]) cube([endstop_x+0.1,endstop_z+0.1,300],center=true);
	}
}

module X_end(Z=150){
    color("gold") difference(){
        union(){
            translate([-delrin_gap_X,rod_smooth_X_gap_Y,Z-5]) cube([delrin_X,nema_axe_h,nema_xy+25],center=true);
            translate([-rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,Z+2.5]) cylinder(d=lm8uu_OD+4,h=nema_xy+10,center=true);//lm8uu
        }
        translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+5,Z])  rotate([-90,0,0]) nema17_neg();
        for(i = [-1,1]){
            translate([0,rod_smooth_X_gap_Y,Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d+0.5,h=rod_smooth_X_h,center=true);// X smooth
            translate([i*delrin_gap_X,delrin_gap_Y,Z+delrin_gap_Z]) rotate([-90,0,0]) delrin_neg();
        }
        X_belt(hole=true,Z=Z);//belt
        translate([-rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,Z]) cylinder(d=lm8uu_OD,h=lm8uu_z*4,center=true);//lm8uu
        translate([623_X_gap_X,623_X_gap_Y,Z]) rotate([90,0,0]) cylinder(d=3.5,h=100,center=true);
        translate([623_X_gap_X+30,623_X_gap_Y,Z]) rotate([90,0,0]) cylinder(d=3.5,h=100,center=true);
        translate([-motor_Z_gap_X,motor_Z_gap_Y,Z_dim]) rotate([180,0,0]) cylinder(d=coupler_d+4,h=Z_dim-Z+5);
                translate([-rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y+5,Z+2.5]) cube([2,lm8uu_OD+5,200],center=true);//lm8uu line cut
    }
}
module Z_axis(Z=150){
	for(i = [-1,1]){
		translate([i*rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,rod_smooth_Z_gap_Z]) cylinder(d=rod_smooth_d,h=rod_smooth_X_h,center=false);// Z smooth
		translate([i*motor_Z_gap_X,motor_Z_gap_Y,motor_Z_gap_Z]) rotate([180,0,0]) nema17();
		translate([i*motor_Z_gap_X,motor_Z_gap_Y,motor_Z_gap_Z-nema_axe_h/2]) rotate([180,0,0]) cylinder(d=8,h=rod_Z_h,center=false);
		translate([i*motor_Z_gap_X,motor_Z_gap_Y,motor_Z_gap_Z-nema_axe_h/2]) rotate([180,0,0]) coupler();
		translate([i*rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,Z]) cylinder(d=lm8uu_OD,h=lm8uu_z*2,center=true);
		translate([M3_endstop_Z_X,endstop_Z_Y,endstop_Z_Z]) rotate([0,-90,180]) endstop();
		translate([M3_endstop_Z_X,endstop_Z_screw_Y,Z-nema_xy/2-15]) cylinder(d=3.5,h=31,center=true); // z endstop screw
	}
}

module Z_motor(){
    color("gold") for(i = [-1,1]){
        difference(){
            union(){
                translate([i*(motor_Z_gap_X-20),prof_Z_gap_Y,Z_dim+5]) cube([nema_xy+40,20,10],center=true);
                translate([i*motor_Z_gap_X,motor_Z_gap_Y,Z_dim+5]) cube([nema_xy,nema_xy+1,10],center=true);
                translate([i*motor_Z_gap_X,rod_smooth_Z_gap_Y,Z_dim+5]) cube([15,15+10,10],center=true);
            }
            translate([i*motor_Z_gap_X,motor_Z_gap_Y,motor_Z_gap_Z]) nema17_neg();
            translate([i*rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,rod_smooth_Z_gap_Z]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_X_h,center=false);// Z smooth
            M5s();
        }
    }
}
module Z_end(){
	color("gold") for(i = [-1,1]){
		difference(){
			union(){
				translate([i*(motor_Z_gap_X),prof_Z_gap_Y+30+10,20+5]) cube([20,60,10],center=true);
				translate([i*(motor_Z_gap_X-15),prof_Z_gap_Y+30+10,20+5]) cube([20,60,10],center=true);
				if(i == 1){
					translate([i*(motor_Z_gap_X+15),prof_Z_gap_Y+30+10,20+5+3.5]) cube([10,60,17],center=true);
				}					
			}
			translate([i*rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,rod_smooth_Z_gap_Z]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_X_h,center=false);// Z smooth
			translate([i*motor_Z_gap_X,motor_Z_gap_Y,motor_Z_gap_Z-nema_axe_h/2]) rotate([180,0,0]) cylinder(d=11,h=300,center=false);
			translate([i*(motor_Z_gap_X+15),prof_Z_gap_Y+30-17,20+5]) cube([40.1,60,40],center=true);
			translate([M3_endstop_Z_X+20,endstop_Z_Y,endstop_Z_Z]) rotate([0,-90,180]) endstop_neg();
			M5s();
		}        
	}
}

module Z_endstop(X=0,Y=0,Z=0){
    color("blue") difference(){
        union(){
            translate([X_dim/2+5,prof_Z_gap_Y,40]) cube([10,20,40],center=true);// prof link
            translate([X_dim/2+5,endstop_Z_Y,endstop_Z_Z]) cube([10,endstop_y,endstop_x+3],center=true);// endstop link
            translate([X_dim/2+5,prof_Z_gap_Y+10,endstop_Z_Z]) cube([10,40,endstop_x+3],center=true);// endstop link
            translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+10+2,Z-nema_xy/2]) cube([nema_xy,4,nema_xy/2],center=true);// motor link
            hull(){// screw link
                translate([motor_X_gap_X-nema_xy/2+5,motor_X_gap_Y-nema_axe_h/2+10+2,Z-nema_xy*3/4+2]) cube([10,4,4],center=true);
                translate([motor_X_gap_X-nema_xy/2+5,endstop_Z_screw_Y,Z-nema_xy*3/4+2]) cube([10,10,4],center=true);
            }
        }
        M5s();
        translate([X_dim/2+10+endstop_z/2,endstop_Z_Y,endstop_Z_Z]) rotate([0,-90,180]) endstop_neg();//endstop
        translate([X_dim/2+10+endstop_z/2,endstop_Z_screw_Y,Z-nema_xy/2-15]) cylinder(d=3,h=30,center=true);//screw
        translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+5,Z])  rotate([-90,0,0]) nema17_neg();
    }
}

M5_gap_ends = 15;
M5_gap_motors = 27;
M5_gap_motors_X = nema14_xy/2+prof_dim*1.3;
module M5(){
    color("green")union(){
        translate([0,0,0]) cylinder(d=5+rabio,h=milling_thick+rabio,center=true); 
        translate([0,0,milling_thick]) cylinder(d=12,h=milling_thick,center=true);
    }
}
module M5s(real = false){
    color("green") union(){
        for(i = [-1,1]){
            if(real){ // no idea what the real is for ???
                translate([Y_axis_shift_X,0,0]) union(){
                    translate([i*M5_gap_ends,-Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_end
                    translate([i*M5_gap_ends,-Y_motor_Y_gap-milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_end
                    
                    translate([i*M5_gap_motors,Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_end
                    translate([i*M5_gap_motors,Y_motor_Y_gap+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_end
                }
            }else{
                translate([i*M5_gap_ends,-Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_end
                translate([i*M5_gap_ends,-Y_motor_Y_gap-milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_end
                
                translate([i*M5_gap_motors,Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_motor
                translate([i*M5_gap_motors,Y_motor_Y_gap+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_motor
                // Z motors
                translate([i*100,prof_Z_gap_Y,Z_dim]) M5();
                translate([i*80,prof_Z_gap_Y,Z_dim]) M5();
                // Z end
                translate([i*prof_X_gap,prof_Z_gap_Y+20,20]) M5();
                translate([i*prof_X_gap,prof_Z_gap_Y+50,20]) M5();
            }
            
            
        }
				
				// Y enstop
       // translate([70,Y_dim/2-prof_dim+endstop_x/2,prof_dim+endstop_z/2+5]) rotate([180,180,90])
        translate([endstop_Y_X-endstop_y/6,Y_dim/2,10]) rotate([-90,0,0]) M5();
        //translate([-X_dim/2+40,Y_dim/2-20,10]) rotate([90,0,0]) M5();
        // Z_endstop
        translate([X_dim/2,prof_Z_gap_Y,30]) rotate([0,90,0]) M5();
        translate([X_dim/2,prof_Z_gap_Y,50]) rotate([0,90,0]) M5();
        // elec_holder
        translate([170/2,-Y_dim/2+10,20]) M5();
        translate([-170/2,-Y_dim/2+10,20]) M5();
        // arduino_holder
        translate([-20,prof_Z_gap_Y-10,Z_dim-10]) rotate([90,0,0])M5();
        translate([20,prof_Z_gap_Y-10,Z_dim-10])rotate([90,0,0]) M5();
    }
}

module LCD_holder(){
    color("blue") difference(){
        union(){
            translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y+10,Z_dim+10+4]) cube([14,40,6],center=true);//rod link
            //center
            translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y+10+20,Z_dim+10+4+15]) cube([14,4,36],center=true);//front
        }
        translate([rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,rod_smooth_Z_gap_Z]) cylinder(d=rod_smooth_d+1,h=rod_smooth_X_h,center=false);// Z smooth// rod
        // horiz screw
    }
    
}

module tool_holder(){
    color("blue") difference(){
        union(){
            translate([-rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y+10+25,Z_dim+10+4]) cube([25,90,6],center=true);//rod link
            //center
        }
        translate([-rod_smooth_Z_gap_X,rod_smooth_Z_gap_Y,rod_smooth_Z_gap_Z]) cylinder(d=rod_smooth_d+1,h=rod_smooth_X_h,center=false);// Z smooth// rod
        for(i = [-1,1]){for(j=[0:5]){translate([-rod_smooth_Z_gap_X+i*6,rod_smooth_Z_gap_Y+10+5+j*12,Z_dim+10+4]) cube([6,6,10],center=true);}}
        
    }
    
}

module elec(){
    
    union(){
       //translate([40.5,-54.6,0]) rotate([0,0,0])  import("Arduino_Mega_2560.STL");
        translate([-35,-295/2-60,40]) import("Raspberry_Pi_3.STL");
        //rpi_neg();
        translate([0,(-295-73-1)/2,(38.5+1)/2-14+5]) cube([169+1.05,73+1.05,38.5+1.05],center=true);
        //arduino_neg();
        
    }
}
module arduino_neg(){
    //see here: https://blog.protoneer.co.nz/arduino-uno-and-mega-dimensions/
    translate([27,-54.6,130]) rotate([90,0,180]) union(){
        translate([2.54,14,0]) cylinder(d=3,h=200,center=true); // bottom left screw
        translate([2.54,96.52,0]) cylinder(d=3,h=200,center=true);
        translate([50.8,14+1.3,0]) cylinder(d=3,h=200,center=true);
        translate([50.8,90.17,0]) cylinder(d=3,h=200,center=true);
    }

}

module arduino_holder(){
    color("gold")difference(){
        translate([0,prof_Z_gap_Y-10-3/2,Z_dim-110/2]) cube([60,3,110],center=true);
        translate([0,prof_Z_gap_Y-10-3/2,Z_dim-85/2-20]) cube([40,4,85],center=true);
        arduino_neg();        
        M5s();
    }
}

module rpi_neg(){
    //see here: https://blog.protoneer.co.nz/arduino-uno-and-mega-dimensions/
    translate([0,-295/2-60,20+10])translate([0,5,0]) rotate([0,0,90]) union(){
        translate([0,-58/2,0]) cylinder(d=3,h=200,center=true); // bottom left screw
        translate([0,58/2,0]) cylinder(d=3,h=200,center=true);
        translate([49,-58/2,0]) cylinder(d=3,h=200,center=true);
        translate([49,58/2,0]) cylinder(d=3,h=200,center=true);
    }

}

module relay_neg(){
    translate([-65,-295/2-40,20+10])for(i = [-1,1]){for(j=[-1,1]){
      translate([20.5/2*i,28/2*j,0]) cylinder(d=3,h=200,center=true);  
    }}
}

module elec_holder(){
    color("gold")difference(){
        union(){
            translate([170/2,-Y_dim/2+10,10]) cube([10,30,30],center=true);
            translate([170/2,(-295-73-1)/2,(38.5+1)/2-14+5]) cube([10,73+1+10,38.5+1+10],center=true);
            translate([-170/2,-Y_dim/2+10,10]) cube([10,30,30],center=true);
            translate([-170/2,(-295-73-1)/2,(38.5+1)/2-14+5]) cube([10,73+1+10,38.5+1+10],center=true);
            translate([0,(-295-73-1)/2+7,(38.5+1)+3.5-14+5+4]) cube([169+1+10,50+8,3],center=true);
        }
        
        translate([0,-Y_dim/2+10,10])cube([300,20.5,20.5],center=true);
        translate([0,(-295-73-1)/2,(38.5+1)/2-14+5]) cube([169+1,73+1,38.5+1],center=true);
         translate([0,(-295-73-1)/2,(38.5+1)/2-14+5]) cube([300,73+1-10,38.5+1-5],center=true);
        cube([40,1000,200],center=true);
        rpi_neg();
        relay_neg();
        translate([0,-295/2-40+9,(38.5+1)+3.5-14+5+4])for(i = [-1,1]){for(j=[-1,1]){
          translate([170/2*i,48/2*j,0]) cylinder(d=3,h=20,center=true);  
        }}
        M5s();
    }
}

module full_view(X=0,Y=0,Z=0){
     profs();
    M5s(true);
	//name_printer("OC-Lab");
    translate([Y_axis_shift_X,0,0]) union(){
        Y_axis(X=X,Y=Y,Z=Z);
        Y_moving(X=X,Y=Y,Z=Z);
        Y_motor();
        % Y_end();
        Y_endstop_holder();
        Y_belt_holder(Y);
        Y_plate(Y=Y);
    }
    X_axis(X=X,Y=Y,Z=Z);
    Z_axis(Z=Z);
    X_motor(Z=Z);
    X_end(Z=Z);
    Z_motor();
    Z_end();
    //Z_endstop(X=X,Y=Y,Z=Z);
    M5s();
    LCD_holder();
    tool_holder();
    //fan_cooler(X=X,Y=Y,Z=Z);
    elec();
    elec_holder();
    arduino_holder();
 }
 
//feet();
//camera_holder();
//full_view(X=75,Y=80,Z=100);
Y_endstop_holder();
//arduino_holder();
 // elec_holder();
//Y_moving();
//Y_plate();
//Y_belt_holder();
//X_moving();
//Y_end();
//Y_motor();
//Z_motor();
 //Z_end();
//X_motor();
//X_end();
 //Z_endstop(X=X,Y=Y,Z=Z);
 //LCD_holder();
 //tool_holder();
 
//Y_glass_holder(Y=Y);