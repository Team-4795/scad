$fs = 0.01;
width = 1.05;
length = 0.8;
height = 0.15;
thickness = 0.05;
hole_radius = 0.05;
header_width = 0.6;
header_length = 0.1;
round_corners = true;

// some derived constants for later calculations
radius = hole_radius + thickness;
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
        translate([x,y,0.0]) cube([radius*2,radius*2,height], center=true);
        translate([x,-y,0.0]) cube([radius*2,radius*2,height], center=true);
        translate([-x,y,0.0]) cube([radius*2,radius*2,height], center=true);
        translate([-x,-y,0.0]) cube([radius*2,radius*2,height], center=true);
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

translate([0.0,0.5,0.0]) top_plate();
translate([0.0,-0.5,0.0]) bot_plate();
