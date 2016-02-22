

/* version 3 - walls on all four sides of the box.
	based on ideas from robot base mounting, feb 18.
*/

width=inch(1);
thickness=inch(0.125);

mtgthick=inch(0.1);

extra_thick=inch(0.020);

length=inch(2);
diagthick=2;

holedia = inch(0.180);

function inch(a) = a*25.4;

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
	// bottom - where sensor goes
	cube([inch(2),   inch(1), thickness+extra_thick  ]);   

	// vertical mounting tabs - short sides
	cube([mtgthick, inch(1), inch(0.65)]);

	translate([inch(2)-mtgthick, 0, 0]) {
	    cube([mtgthick, inch(1), inch(0.65)]);
	}

	// long sides
	cube([inch(2), mtgthick, inch(0.65)]);

	translate([0, inch(1)-mtgthick, 0]) {
	    cube([inch(2), mtgthick, inch(0.65)]);
	}


    }
}

// positive model of wcp hall-effect sensor
module wcp971() {

    difference() {
	union(){
	    cube([inch(.760), inch(.568), inch(.0635)+extra_thick]);
	    translate([ inch((.760-.330)/2), 0, 0]) {
		cube([ inch(.330), inch(1.500), inch(.104)+extra_thick]);
	    }
	    translate([ inch((.760-.330)/2), inch(0.9), 0]) {
		cube([ inch(.330), inch(0.730), inch(.2)]);
	    }
	    
	    translate([inch((.760-.12)/2 ), inch(.190), -1]) {
		cylinder(h=8, d=inch(.07),  $fn=20);
	    }
	    translate([inch(.760-(.750-.12)/2 ), inch(.190), -1]) {
		cylinder(h=8, d=inch(.07),  $fn=20);
	    }

 
	}

	translate([inch((.760-.510)/2 ), inch(.165), -1]) {
	    cylinder(h=8,d=inch(.100),  $fn=20);
	}

	translate([inch(.760 - (.760-.510)/2 ), inch(.165), -1]) {
	    cylinder(h=8,d=inch(.100),  $fn=20);
	}

    }
}

// put it all together
union(){
    difference () {
	bracket();

	translate([inch(1.875),inch(.875), thickness+0.010+extra_thick]) {
	    rotate([0,180,90]) {
		wcp971();
	    }
	}

	// hole to aid in removing sensor from bracket
	translate([inch(1.25), inch(0.5), -1]) {
	    cylinder(h=8,d=inch(0.09),  $fn=20);
	}

	    // holes in vertical mounting frame - short side
	translate([-1, inch(0.75),inch(0.3) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia,  $fn=20);
	    }
        }
	translate([-1, inch(0.25), inch(0.3) ]) {
	    rotate([0,90,0]) {
		cylinder(h=8,d=holedia, $fn=20);
	    }
        }

	// holes in vertical mounting frame - long sides
	translate([inch(0.5), -1, inch(0.3) ]) {
	    rotate([0,90,90]) {
		cylinder(h=inch(2),d=holedia,  $fn=20);
	    }
        }

	translate([inch(1.5), -1, inch(0.3) ]) {
	    rotate([0,90,90]) {
		cylinder(h=inch(2),d=holedia,  $fn=20);
	    }
        }	
    }
}