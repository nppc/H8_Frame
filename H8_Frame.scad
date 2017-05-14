//H8 protexted propellers frame
$fn=150;

SUPPORTS=1;     // add supports for not enabling supports in Slicer

PROP=45+2;   // diameter of propeller plus clearance (1mm from each side)
PROPGUARD_T=0.8;    // Thickness of propeller quards (mm)
PROPGUARD_H=6;    // Height of propeller quards (mm)
MOTOR_D=6.12;     //Moptor Diameter (mm)
MOTORMOUNT_H=10;     // height of motor mount
MOTORSCENTER_DX=48;  // Distance between motor centers (X). 63 - H8
MOTORSCENTER_DY=48;  // Distance between motor centers (Y). 63 - H8

//Board();
//LiPo();
translate([0,0,(PROPGUARD_H)/2-3])CameraMount();

//Propeller();

translate([MOTORSCENTER_DX/2,MOTORSCENTER_DY/2,0])rotate([0,0,-135])Propeller();
translate([-MOTORSCENTER_DX/2,MOTORSCENTER_DY/2,0])rotate([0,0,-45])Propeller();
translate([MOTORSCENTER_DX/2,-MOTORSCENTER_DY/2,0])rotate([0,0,135])Propeller();
translate([-MOTORSCENTER_DX/2,-MOTORSCENTER_DY/2,0])rotate([0,0,45])Propeller();


// spacers for front/back rigidity
translate([MOTORSCENTER_DX/2,0,0])cube([PROPGUARD_T,MOTORSCENTER_DY-PROP-PROPGUARD_T,PROPGUARD_H],center=true);
translate([-MOTORSCENTER_DX/2,0,0])cube([PROPGUARD_T,MOTORSCENTER_DY-PROP-PROPGUARD_T,PROPGUARD_H],center=true);

// spacers for sides rigidity
translate([0,MOTORSCENTER_DY/2,0])cube([MOTORSCENTER_DX-PROP-PROPGUARD_T,PROPGUARD_T,PROPGUARD_H],center=true);
translate([0,-MOTORSCENTER_DY/2,0])cube([MOTORSCENTER_DX-PROP-PROPGUARD_T,PROPGUARD_T,PROPGUARD_H],center=true);


module Propeller(){
    difference(){
        union(){
            cylinder(d=PROP+PROPGUARD_T*2,h=PROPGUARD_H, center=true);
            for(i=[0:120:240])rotate([0,0,i]){
                translate([PROP/4+PROPGUARD_T, 0, -3])cube([PROP/2,PROPGUARD_T,PROPGUARD_H],center=true);
      rotate([0,180,180])translate([0,0,2.9])Reinforcement1(); 
            }
            translate([0,0,-PROPGUARD_H/2-MOTORMOUNT_H/2])cylinder(d=MOTOR_D+1.6, h=MOTORMOUNT_H, center=true);
     // plate for Controller mount under the prop
     translate([PROP/2+PROPGUARD_T,0,-PROPGUARD_H/2-1.5])rotate([90,30,-90])linear_extrude(height=PROP/2, scale= 0.8)circle(d=4.2,$fn=3);
        }
        cylinder(d=PROP,h=PROPGUARD_H+0.01, center=true); // cutout for propeller
        translate([0,0,-PROPGUARD_H/2-MOTORMOUNT_H/2])cylinder(d=MOTOR_D, h=MOTORMOUNT_H+1, center=true); // cutout for motor
      // cutout for controller board
     translate([PROP/2+PROPGUARD_T,0,-PROPGUARD_H/2-4])rotate([0,0,0])cube([PROP-MOTOR_D,10,4],center=true);
      
        }
   translate([0,0,-PROPGUARD_H/2-0.6])difference(){
     cylinder(d=MOTOR_D+1.6,h=0.6);
     cylinder(d=MOTOR_D-1.2,h=0.6);
   }
   Reinforcement2();



     // Supports
     if(SUPPORTS==1){
        for(i=[0:60:300])rotate([0,0,i])
            translate([MOTOR_D/4+PROPGUARD_T, 0,0])cube([MOTOR_D/2,PROPGUARD_T,PROPGUARD_H],center=true);
            translate([0,0,PROPGUARD_H/2-0.6])cylinder(d=MOTOR_D+1.6,h=0.6);
         }

}

module Board(){
color("BLUE"){
     translate([0,0,-PROPGUARD_H/2-3]){
         cube([25,23,2], center=true);
         rotate([0,0,45])cube([55,4,2],center=true);
         rotate([0,0,-45])cube([55,4,2],center=true);
     }
}
color("WHITE")translate([6,-4,-PROPGUARD_H/2-6])cube([11,8,2]);

}


module LiPo(){
     translate([0,0,-PROPGUARD_H/2-10])color("GRAY")cube([27,16,8],center=true);
}


module CameraMount(){
     //camera footprint 15x7
     difference(){
         translate([1.3,0,1.5])cube([8+1.6,15.4+1.6,3],center=true);
         translate([1.4,0,5])rotate([0,4,0])cube([8.4,15.4,9.1],center=true);
     }
     translate([-4,-8.9])rotate([0,0,40])cylinder(d=3.5,h=3,$fn=3);
     translate([-4,8.9])rotate([0,0,-40])cylinder(d=3.5,h=3,$fn=3);
}

module Reinforcement1(){
    difference(){
        cylinder(d=PROP+PROPGUARD_T*2,h=PROPGUARD_H, center=true);
        cylinder(d=PROP,h=PROPGUARD_H+0.01, center=true); // cutout for propeller
        translate([0,0,3-PROPGUARD_H])cube([PROP*2,PROP*2,PROPGUARD_H], center=true);
       
        translate([PROP/2,-14,0])rotate([35,0,0])cube([PROP,PROP,10], center=true);
        translate([PROP/2,14,0])rotate([-35,0,0])cube([PROP,PROP,10], center=true);
        translate([-5,0,0])cube([PROP+5,PROP+5,PROPGUARD_H*2], center=true);
    }
}

module Reinforcement2(){
    translate([4,0,-5])rotate([90,-60,180])cylinder(d=3,h=2.3,$fn=3, center=true);
}
