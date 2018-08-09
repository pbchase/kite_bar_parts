// Modules for generating a rounded cylinder, rounded disc, and torus
// Author: Philip B Chase, <philipbchase@gmail.com>

/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to modules to generate a rounded cylinder, rounded disc, and torus. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/

Usage:

    $fn=30;
    height=10;
    major_radius=7;
    minor_radius=3;

    rounded_cylinder(height, major_radius, minor_radius);

      or

    rounded_disc(major_radius, minor_radius);

*/


module rounded_cylinder(height, major_radius, minor_radius) {
    // height is the total height of the cylinder
    // major_radius is the radius of the flat zone at the top and bottom of the cylinder
    // minor_radius is the radius of curvature of the rounded edges
    // the radius of the cylinder is major_radius + minor_radius
    // the cylinder is centered at [0,0,0]
    torus_displacement = 0.5 * height - minor_radius;
    hull(){
        translate([0,0,torus_displacement])
            torus(major_radius, minor_radius);
        translate([0,0,-torus_displacement])
            torus(major_radius, minor_radius);
    }
}

module rounded_disc(major_radius, minor_radius) {
    // the disc is centered at [0,0,0]
    hull() {
        torus(major_radius, minor_radius);
    }
}

module torus(major_radius, minor_radius){
    // minor_radius is the radius of the cross section of the torus
    // major_radius is the radius torus
    //$fn=30;
    rotate_extrude(convexity = 10)
        translate([major_radius,0,0])
            circle(minor_radius);
}