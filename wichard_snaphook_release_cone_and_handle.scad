// 3D model for a handle with cone to release a Wichard quick release snap shackle
// See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
// Make two pieces per snap shackle.
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to be assembled on the a 1/16" stainless steel wire rope that passes through the release gate of the snap shackle. The narrow tip of each piece faces the shackle. The handles are affixed the wire with swaged fittings recessed in side the handles.  When pulled, the ball pulls the opposite cone into the release gate to open the snap shackle.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a handle with cone to release a Wichard quick release snap shackle. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// The dimensions of the handle
handle_r = 14;
bottom_truncation = 0.33 * handle_r;
cutout_depth = 8;
cutout_lower_r = 7;
cutout_upper_r = 3/16 * 25.4;

// The dimensions of the cone
// For model 2674, use mid_r = 7, top_h = 25
// For model 2776, use mid_r = 8, top_h = 31
top_h = 31;
top_r1 = 8;
top_r2 = 3;

// Dimensions of the cone extended to the center of the cylinder
cone_h = top_h + handle_r;
cone_r2 = 3;
cone_r1 = (top_r1 - top_r2) * cone_h / top_h;

// The dimensions of the bore that passes through the handle and cone
bore_r = 1/16 * 25.4;
bore_h = 2 * handle_r + top_h;

// set the facet number high (40-60) for final generation
$fn = 60;

difference() {
    union() {  // stack a series of cylinders from z=0 going up.
        // start with a handle, A
        translate([0,0,handle_r - bottom_truncation])
            sphere(r=handle_r);
            
        // Add a cone, D
        translate([0,0,handle_r - bottom_truncation])
            cylinder(h = cone_h, r1 = cone_r1, r2 = cone_r2);

    }
    // subtract the center bore and bottom of handle and everything below z=0
    union() {
        // define the center bore
        cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
        
        // define cube as big as the handle with a top at z=0
        translate([0,0,-handle_r])
            cube (size=2*handle_r, center=true);
        
        // define the cone cut out ftom the back of the handle
        cylinder(h = cutout_depth, r1 = cutout_lower_r, r2 = cutout_upper_r);
        
    }
}
