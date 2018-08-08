// 3D model for a separation block for a kite-bar control system
// The separation block defines the interface of the flying lines
// with the trimline and the flag line.
// See http://philipbchase.com/moveable-stoppers/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This component transfers load from the main flying lines by providing a pair of parallel bore holes. Each flying line passes through a bore hole. The flying line is trapped on the lower side of the block via a larks head of relatively fat line. The pair of bore holes surround a larger, central bore hole. The central bore hole allows a heavier line to be secured to the separation block. The upper end is secured via an overhand knot. The lower end of the central line entraps a low friction ring that acts as a pulley for the trim line.

    This component should be printed with 100% infill.

*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a separation block for a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

use <elliptical_torus.scad>;

$fn=30;

// Body dimensions
overall_width=22;  // x
overall_depth=14;  // y
overall_height=25; // z
// radii of block corners and edges
r_body = 3;

// Dimensions of central bore
central_bore_radius = 3/16 * 25.4 / 2;
central_bore_length = overall_height + 2;

// Dimensions of main line bore
main_line_bore_radius = 0.125 * 25.4 / 2; 
main_line_bore_length = overall_height + 2;
main_line_bore_x_offset = 6.5;


difference() {
    elliptical_body();
    central_bore(central_bore_radius, central_bore_length);
    flying_line_bore(main_line_bore_radius, main_line_bore_length, main_line_bore_x_offset);
    flying_line_bore(main_line_bore_radius, main_line_bore_length, -main_line_bore_x_offset);
}


module central_bore(radius, length) {
    cylinder(h=length, r=radius, center=true);
}

module flying_line_bore(radius, length, x_offset) {
    translate([x_offset,0,0])
        cylinder(h=length, r=radius, center=true);
}

module elliptical_body() {
    end_sphere_height = 5;
    z_translation = overall_height/2 - end_sphere_height/2;
    hull() {
        translate([0,0,z_translation])
            elliptical_sphere(overall_width, overall_depth, end_sphere_height);
        translate([0,0,-z_translation])
            elliptical_sphere(overall_width, overall_depth, end_sphere_height);
    }
}
