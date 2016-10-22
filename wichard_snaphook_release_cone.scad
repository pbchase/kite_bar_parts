// 3D model for a cone to release a Wichard quick release snap shackle
// See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
// Make two cones per snap shackle.
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to be assembled on the a 1/16" stainless steel wire rope that passes through the release gate of the snap shackle. The narrow tip of each cone faces the shackle. Each cone is also threaded through a ball to provide a handle.  When pulled the ball pulls the opposie cone into the release gate to open the snap shackle.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a cone to release a Wichard quick release snap shackle. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// The dimensions of the base cylinder
base_h = 7;
base_r = 12.7/2;

// The dimensions of the second cylinder and its fillet
mid_h = 9;
// For model 2674, use mid_r = 7/2
// For model 2776, use mid_r = 8/2
mid_r = 8/2;
mid_fillet_r = 1.5;

// The dimensions of the cone
top_h = 25;
top_r1 = mid_r;
top_r2 = 4/2;

// The dimensions of the bore tha passes through the entire stack of cylinders and cones
bore_r = 1/16 * 25.4/2;
bore_h = base_h + mid_h + top_h;

// set the facet number high (40-60) for final generation
$fn = 30;

difference() {
    union() {  // stack a series of cylinders from z=0 going up.
        // start with a squat cylinder, A
        cylinder(h = base_h, r1 = base_r, r2 = base_r);

        // add a smaller diameter cylinder, B
        translate([0,0,base_h])
            cylinder(h = mid_h, r1 = mid_r, r2 = mid_r);

        // Add a crude fillet, C, between A and B
        translate([0,0,base_h])
            fillet(mid_r, mid_fillet_r);

        // Add a cone, D
        translate([0,0,base_h+mid_h])
            cylinder(h = top_h, r1 = top_r1, r2 = top_r2, center = true/false);

    }
    // subtract the center bore
    cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
}

module fillet(r1, r2){
    // r1 is radius of the cylinder whose base needs a fillet around it.
    // r2 is the radius of that fillet.
    //$fn=30;
    difference() {
        cylinder(r=r1 + r2, h=r2);
        translate([0,0,r2])
            rotate_extrude(convexity = 10)
                translate([r1 + r2, 0, 0])
                    circle(r = r2);
    }
}