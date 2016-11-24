// 3D model for a handle with cone to release a Wichard quick release snap shackle
// See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
// Make two pieces per snap shackle.
// Author: Philip B Chase, <philipbchase@gmail.com>
/*
Assembly: This design is meant to be assembled on a short, folded, segment of 300# Spectra line that passes through the release gate of the snap shackle. The narrow tip of each piece faces the shackle. The spectra is folded in half, tied at the loose end and pulled through the entire assembly with a wire fid.  The folded end of the line is locked in place by a very small segment of line knotted and larksheaded on the end. The knots are recessed inside the handles.

Use: When pulled, the ball pulls the opposite cone into the release gate to open the snap shackle. Once released, the cone often stays in the release gate holding the gate open. This allows the gate to be reclosed with zero-force before pulling the cone out of the gate.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a handle with cone to release a Wichard quick release snap shackle. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// The dimensions of the handle
handle_r = 14;
bottom_truncation = 0.33 * handle_r;
cutout_sphere_radius = 11;
cutout_sphere_center_height = 6;

// Dimensions of the cone extended into the cylinder
cone_r2 = 4.5/2;  //tip diameter
cone_r3 = 7.0/2;  //diameter in gate at release
h3_minus_h2 = 8.5;  //distance from one spring gate centerline to opposite spring gate interior surface
cone_slope = (cone_r3-cone_r2)/h3_minus_h2;
cone_h = 30;
cone_r1 = cone_r2 + cone_slope*cone_h;

// The dimensions of the bore that passes through the handle and cone
bore_r = 2.5/2;
bore_h = 2 * handle_r + cone_h;

// set the facet number high (40-60) for final generation
$fn = 50;

difference() {
    union() {  // stack a series of cylinders from z=0 going up.
        // start with a handle, A
        translate([0,0,handle_r - bottom_truncation])
            sphere(r=handle_r);

        // Add a cone, D
        translate([0,0,2*handle_r - 2*bottom_truncation])
            cylinder(h = cone_h, r1 = cone_r1, r2 = cone_r2);


    }
    // subtract the center bore and bottom of handle and everything below z=0
    union() {
        // define the center bore
        cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);

        // define cube as big as the handle with a top at z=0
        translate([0,0,-handle_r])
            cube (size=2*handle_r, center=true);

        // define the sphere cut out from the back of the handle
        translate([0,0,cutout_sphere_center_height])
            sphere(r=cutout_sphere_radius);

    }
}

