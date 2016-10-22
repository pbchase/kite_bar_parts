// 3D model for a handle with cone to release a Wichard quick release snap shackle
// See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
// Make two pieces per snap shackle.
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to be assembled on a 1/16" stainless steel wire rope or line that passes through the release gate of the snap shackle. The narrow tip of each piece faces the shackle. The handles are affixed to the wire with swaged fittings (or knots recessed inside the handles.  When pulled, the ball pulls the opposite cone into the release gate to open the snap shackle.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a handle with cone to release a Wichard quick release snap shackle. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// The dimensions of the handle
handle_r = 14;
bottom_truncation = 0.33 * handle_r;
cutout_sphere_radius = 11;
cutout_sphere_center_height = 6;

// The dimensions of the cone
// For model 2674, use top_r1 = 7, top_h = 25
// For model 2776, use top_r1 = 8, top_h = 31
top_h = 30;
top_r1 = 10;
top_r2 = 2;

// Dimensions of the cone extended to the center of the cylinder
cone_h = top_h + handle_r;
cone_r2 = top_r2;
cone_r1 = top_r1;

// The dimensions of the bore that passes through the handle and cone
bore_r = 1/16 * 25.4/2;
bore_h = 2 * handle_r + cone_h;

// set the facet number high (40-60) for final generation
$fn = 50;

difference() {
    union() {  // stack a series of cylinders from z=0 going up.
        // start with a handle, A
        translate([0,0,handle_r - bottom_truncation])
            sphere(r=handle_r);

        // Add a cone, D
        translate([0,0,handle_r - bottom_truncation])
            difference() {
                elliptical_cone(cone_r1, cone_h, cone_r2);
                // truncate the bottom of the cone
                translate([0,0,-1])
                cylinder(h=0.2*cone_h, r=2*cone_r1 + 2*cone_r2, center=false);
            }


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

module elliptical_cone(a_axis, b_axis, r_cone_tip){
    // a_axis is the diameter f the cone base,
    // b_axis is the cone height
    // r_cone_tip is the radius tip (top) of the cone)
    //$fn=30;
    translate([0,0,b_axis])
        rotate (a = [0,180,0])
            difference() {
                cylinder(h=b_axis, r=a_axis+r_cone_tip);

                rotate_extrude(convexity = 10)
                    translate([a_axis+r_cone_tip,0,0])
                        ellipse(a_axis, b_axis);
            }
}


module ellipse(a_axis, b_axis) {
    scale([a_axis/a_axis,b_axis/a_axis])
        circle(r=a_axis);
}
