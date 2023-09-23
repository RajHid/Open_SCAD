//Messuhr =========================

//HMessUhr=14;
//FassParameter=0.34;



//// Dial_Pin_Probe ==================
HDome=1.5;
Sph_D=12;
DGrabbleTopPin=8;
HGrabbleTopPin=13.0;

DDialStaticTopPin=8;
HDialStaticTopPin=1;    

DDialHousing=52;    //Diameter Dial Housing
HDialHousing=20;    //Height Dial Housing

D2DialHousing=58;    //Diameter Dial Housing
H2DialHousing=5;    //Height Dial Housing


DDialStatic=8;     //Diameter Static probe pin
HDialStatic=18.5;    //Heigh Static probe pin
D2DialStatic=7;    // Chamfer diameter two
H2DialStatic=2.1;   // Chamfer Heigth


DDialProbe=4.5;     //Diameter moving probe pin
HDialProbe=11.5;      //Heigh moving probe pin (aproximately 10mm probing way)


D1DialProbeTip=5.0;         // Diameter Knurled Cylinder    -- VALUE OK!
H1DialProbeTip=4.0;         // Kurled Cylinder              -- VALUE OK!
D2DialProbeTip=3.0;         // Cone Diameter Small          -- VALUE OK!
H2DialProbeTip=4.0;         // Cylinder                     -- VALUE OK!
SphereDialPropeTip=2.4;     // Hardened Steelball           -- VALUE OK!

ProbeLengthMove=H1DialProbeTip+
                H2DialProbeTip+
                HDialProbe+
                SphereDialPropeTip/2;
echo("ProbeLengthMove",ProbeLengthMove);

ProbeLengthStaticBottom=HDialStatic+
                        H2DialStatic;

ProbeLengthStaticTop=0;

FN_Probe=12;            //Number of facettes of objects



// Modules ==========================
//Base();
//Dial_Probe_Pin();
//Dial_Probe_Pin_Tip();
//Dial_Housing();
translate([0,0,0]){ //10.1 Dist to Backface
Dial_Gauge();
}

cube(100);

//TopProbePin();
module TopProbePin(){
    translate([0,-HDialHousing/2,DDialHousing/2+HDialStaticTopPin+HGrabbleTopPin-Sph_D/2+HDome]){
        rotate([0,0,0]){
            difference(){
                sphere(d=Sph_D);
                translate([0,0,-HDome]){
                    cube(Sph_D,center=true);
                }
            }
        }
    }
    translate([0,-HDialHousing/2,DDialHousing/2+HDialStaticTopPin+HGrabbleTopPin]){
        rotate([-180,0,0]){
            cylinder(h=HGrabbleTopPin,d=DGrabbleTopPin);
        }
    }
    translate([0,-HDialHousing/2,DDialHousing/2+HDialStaticTopPin]){
        rotate([-180,0,0]){
            cylinder(h=4*HDialStaticTopPin,d=DDialStaticTopPin);
        }
    }
}

module Dial_Gauge(){
    translate([0,HDialHousing/2,DDialHousing/2+ProbeLength]){
        rotate([0,0,0]){
            TopProbePin();
        }
    }
    translate([0,HDialHousing/2,DDialHousing/2+ProbeLengthStaticBottom+ProbeLengthMove]){
        rotate([90,0,0]){
            translate([0,0,0]){
                #Dial_Housing();
            }
        }
    }
    translate([0,0,ProbeLength]){
        rotate([180,0,0]){
            //Dial_Probe_Pin();
            //Probe_Pin_Static();
        }
    }
}
//Dial_Housing();
module Dial_Housing(){
    cylinder(HDialHousing,d1=DDialHousing,d2=DDialHousing,
        center=false
        ,$fn=FN_Probe*2);
        translate([0,0,0]){
            cylinder(H2DialHousing,d1=D2DialHousing,d2=D2DialHousing,
                center=false
                ,$fn=FN_Probe*2);
        }
    rotate([90,0,0]){
        translate([0,HDialHousing/2,DDialHousing/2]){
           Probe_Pin_Static();
        }
    }
}
Probe_Pin_Move();
module Probe_Pin_Move(){
    Dial_Probe_Pin_Tip();
    translate([0,0,SphereDialPropeTip/2+H2DialProbeTip+H1DialProbeTip]){
        Probe_Pin_Shaft();
        translate([0,0,0]){
            TopProbePin();
        }
    }
}

//Probe_Pin_Static();
module Probe_Pin_Static(){
    cylinder(HDialStatic,d1=DDialStatic,d2=DDialStatic,center=false,$fn=FN_Probe);
    translate([0,0,HDialStatic]){
        cylinder(H2DialStatic,d1=DDialStatic,d2=D2DialStatic,center=false,$fn=FN_Probe);
        translate([0,0,HDialProbe]){
            //Dial_Probe_Pin_Tip();
            }
        }
    }
//Probe_Pin_Shaft();
module Probe_Pin_Shaft(){
    cylinder(HDialProbe,d1=DDialProbe,d2=DDialProbe,center=false,$fn=FN_Probe);
}    
    
//Dial_Probe_Pin_Tip();
module Dial_Probe_Pin_Tip(){
    translate([0,0,SphereDialPropeTip/2]){
        sphere(d=SphereDialPropeTip,$fn=FN_Probe*2);
        cylinder(H2DialProbeTip,d1=D2DialProbeTip,d2=D1DialProbeTip,center=false,$fn=FN_Probe);
        translate([0,0,H2DialProbeTip]){
            cylinder(H1DialProbeTip,d1=D1DialProbeTip,d2=D1DialProbeTip,center=false,$fn=FN_Probe*3);
        }
    }
}