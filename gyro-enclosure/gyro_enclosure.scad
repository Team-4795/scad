function mm(inches) = inches * 25.4;

$fs = 0.01;
width         = mm(1.05);
length        = mm(0.80);
height        = mm(0.15);
thickness     = mm(0.05);
hole_radius   = mm(0.05);
header_width  = mm(0.60);
header_length = mm(0.10);
round_corners = true;

// some derived constants for later calculations
radius = hole_radius + thickness;
diam = radius * 2;
x = (width / 2) - radius;
y = (length / 2) - radius;

// draws in the four cylinders that define the corners of the enclosure
module corners()
{
    if(round_corners) {
        translate([x,y,0.0]) cylinder(h=height, r=radius, center=true);
        translate([x,-y,0.0]) cylinder(h=height, r=radius, center=true);
        translate([-x,y,0.0]) cylinder(h=height, r=radius, center=true);
        translate([-x,-y,0.0]) cylinder(h=height, r=radius, center=true);
    } else {
        translate([x,y,0.0]) cube([diam,diam,height], center=true);
        translate([x,-y,0.0]) cube([diam,diam,height], center=true);
        translate([-x,y,0.0]) cube([diam,diam,height], center=true);
        translate([-x,-y,0.0]) cube([diam,diam,height], center=true);
    }
}

module body()
{
    hull() corners();
}

// slots for header access, top plate only
module slots()
{
    y2 = ((length - header_length) / 2) + 0.1;
    translate([0.0,y2,0.0]) cube([header_width,header_length+0.2,height+0.1], true);
    translate([0.0,-y2,0.0]) cube([header_width,header_length+0.2,height+0.1], true);
}

module bot_plate()
{
    difference() {
        body();
        // holes for bolts
        translate([x,y,0.0]) cylinder(height+0.1, r=hole_radius, center=true);
        translate([x,-y,0.0]) cylinder(height+0.1, r=hole_radius, center=true);
        translate([-x,y,0.0]) cylinder(height+0.1, r=hole_radius, center=true);
        translate([-x,-y,0.0]) cylinder(height+0.1, r=hole_radius, center=true);
        // hollow out the insides
        translate([0.0,0.0,thickness]) difference() {
            body();
            corners();
            // define the walls
            x3 = (width - thickness) / 2.0;
            y3 = (length - thickness) / 2.0;
            translate([x3,0.0,0.0]) cube([thickness,length,height], center=true);
            translate([-x3,0.0,0.0]) cube([thickness,length,height], center=true);
            translate([0.0,y3,0.0]) cube([width,thickness,height], center=true);
            translate([0.0,-y3,0.0]) cube([width,thickness,height], center=true);
        }
    }
}

// same as bot_plate, but with the header slots
module top_plate()
{
    difference() {
        bot_plate();
        slots();
    }
}

translate([0.0,mm(0.5),0.0]) top_plate();
translate([0.0,mm(-0.5),0.0]) bot_plate();
