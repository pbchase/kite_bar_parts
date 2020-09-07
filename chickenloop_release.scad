// 3D model for a chickenloop release for a kite-bar control system
// The chickenloop release is the thing you push away to release the kite from your harness.
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This component functions as the release for the chickenloop and a below-the-bar handle for the kite. It must be comfortable when gripping a timmed-out kite. It must slide freely on a doubled trimline of 4mm Amsteel Blue. The Amsteel passes through the large center bore. A stainless steel pin of about 1/8" diameter, crosses and divides the center bore to provide a retainer for the trimline. In addition to the trimline and the retaining pin, the center bore must be large enough to accommodate a 40mm cotter pin used to retain the free end of the chickenloop. The side bores retain a segment of 1/8" bungie that pushes the chickenloop release down onto the cotter pin. These bores must be long enough to allow enough bungie to stretch 40mm so the chickenloop release can easily be pulled off the cotter pin to release it.

    This component should be printed with 100% infill.

*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a chickenloop release for a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

use <rounded_cylinder.scad>;

$fn=30;

// Body dimensions
overall_width=24;  // x
overall_depth=overall_width;  // y
overall_height=40; // z
// radii of block corners and edges
r_body = 3;

// Dimensions of central bore
// Drill out to 3/16"
central_bore_radius = 0.5 * 25.4 / 2;
central_bore_length = overall_height + 2;

// Dimensions of bungie bore
bungie_bore_radius = 7/64 * 25.4 / 2; 
bungie_bore_length = overall_height + 2;
bungie_bore_x_offset = 8.5;

// Dimensions of retaining pin bore
// See https://www.mcmaster.com/89085K87
pin_bore_radius = 0.102 * 25.4 / 2; 
pin_bore_length = overall_depth + 2;
pin_bore_z_offset = overall_height / 2 - r_body - pin_bore_radius;


difference() {
    cylindrical_body(overall_width, overall_depth, overall_height, r_body);
    central_bore(central_bore_radius, central_bore_length);
    flying_line_bore(bungie_bore_radius, bungie_bore_length, bungie_bore_x_offset);
    flying_line_bore(bungie_bore_radius, bungie_bore_length, -bungie_bore_x_offset);
    pin_bore(pin_bore_radius, pin_bore_length, -pin_bore_z_offset);
}


module central_bore(radius, length) {
    cylinder(h=length, r=radius, center=true);
}

module flying_line_bore(radius, length, x_offset) {
    translate([x_offset,0,0])
        cylinder(h=length, r=radius, center=true);
}

module pin_bore(radius, length, z_offset) {
    translate([0,0,z_offset])
        rotate([90,0,60])
            cylinder(h=length, r=radius, center=true);
}

module cylindrical_body(overall_width, overall_depth, overall_height, radius_of_edges) {
    major_radius = overall_width/2;
    y_scale = overall_depth/overall_width;
    scale([1,y_scale,1]) {
        rounded_cylinder_2(overall_height, major_radius, radius_of_edges);
    }
}
