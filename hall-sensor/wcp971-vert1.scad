
width=inch(1);
thickness=inch(0.125);
length=inch(2);
diagthick=2;

holedia = inch(.2);


function inch(a)  =     a*25.4;

module mytriangle()
{
    intersection() {
	cube([width, diagthick, width]);
	translate([-width+6, 0, 0]) {
	    rotate([0, 45, 0]) {
		cube([width, diagthick, width]);
	    }
	}    
    }
}

module bracket() {
    union(){
	cube([inch(2),   inch(1), thickness  ]);   // bottom - where sensor goes
	cube([thickness, inch(1), inch(1) ]);	// vertical mounting tail
    
        mytriangle();
	translate([0, width-diagthick, 0]) {
	    mytriangle();
	}

    }
}

// positive model of wcp hall-effect sensor
module wcp971() {

    difference() {
	union(){
	    cube([inch(.750), inch(.550), inch(.0635)]);
	    translate([ inch((.750-.330)/2), 0, 0]) {
		cube([ inch(.330), inch(1.500), inch(.104)]);
	    }
	    translate([ inch((.750-.330)/2), inch(0.9), 0]) {
		cube([ inch(.330), inch(0.60), inch(.2)]);
	    }
	    
	    translate([inch((.750-.12)/2 ), inch(.190), -1]) {
		cylinder(h=8, d=inch(.06),  $fn=20);
	    }
	    translate([inch(.750-(.750-.12)/2 ), inch(.190), -1]) {
		cylinder(h=8, d=inch(.06),  $fn=20);
	    }
	    
	}

	translate([inch((.750-.510)/2 ), inch(.165), -1]) {
	    cylinder(h=8,d=inch(.100),  $fn=20);
	}

	translate([inch(.750 - (.750-.510)/2 ), inch(.165), -1]) {
	    cylinder(h=8,d=inch(.100),  $fn=20);
	}
    }
}

// put it all together
union(){
    difference () {
	bracket();

	translate([inch(1.875),inch(.875),inch(0.126)]) {
	    rotate([0,180,90]) {
		wcp971();
	    }
	}

	// bottom-side holes 
/*
	translate([15,20,0]) {
		cylinder(h=6,d=6);
	}
*/

// holes in vertical tail for mounting
	translate([-1, inch(0.75),inch(0.3) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia);
	    }
        }
	translate([-1, inch(0.25), inch(0.3) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia);
	    }
        }

	translate([-1, inch(0.75),inch(0.8) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia);
	    }
        }
	translate([-1, inch(0.25), inch(0.8) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia);
	    }
        }
    }
}