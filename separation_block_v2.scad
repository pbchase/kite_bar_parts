// 3D model for a separation block for a kite-bar control system
// The separation block defines the interface of the flying lines
// with the trimline and the flag line. This model requires no 
// additional parts to be complete. The trim threads directly 
// through the central, curving path.
// See http://philipbchase.com/moveable-stoppers/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This component transfers load from the main flying lines by providing a pair of parallel bore holes. Each flying line passes through a bore hole. The flying line is trapped on the lower side of the block via a larks head of relatively fat line. The pair of bore holes surround a larger, toroidal central bore hole. The curved central bore provides a low friction path for the trim line. 

    This component should be printed with 100% infill.

*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a separation block for a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

use <rounded_cylinder.scad>;

$fn=30;

// Body dimensions
overall_width=26;  // x
// overall_depth, the y-axis dimension, is a product of the trim_line bore dimensions
overall_height=30; // z
// radii of block corners and edges
r_body = 3;

// Dimensions of main line bore
main_line_bore_radius = 0.125 * 25.4 / 2;
main_line_bore_length = overall_height + 2;
main_line_bore_x_offset = overall_width/3.4;
echo("main_line_bore_x_offset", main_line_bore_x_offset);
// Dimensions of trim line bore
// The central bore is a half torus with a minor diameter large 
// enough to accommodate a 5mm line. Larger, more comfortable trim 
// lines would require a larger bore diameter.
// 
trim_line_bore_oversize_factor = 1.10;
trim_line_diameter = 5;
trim_line_bore_minor_radius = trim_line_diameter * trim_line_bore_oversize_factor / 2;
trim_line_bore_major_radius = 2.4 * trim_line_diameter / 2;
trim_line_bore_major_radius = 4 * trim_line_diameter / 2;
trim_line_bore_translation = -1 * (trim_line_bore_major_radius);

overall_depth= 2 * (trim_line_bore_major_radius - trim_line_bore_minor_radius);  // y
echo ("overall_depth",overall_depth);
echo ("cross-sectional area under trimline", overall_depth * (overall_height/2 + trim_line_bore_translation) + 0.5 * 3.1415 * pow(2,trim_line_bore_major_radius-trim_line_bore_minor_radius) );

// Assemble the primitives 
difference() {
    cylindrical_body(overall_width, overall_depth, overall_height, r_body);
    trim_line_bore(trim_line_bore_major_radius, trim_line_bore_minor_radius, trim_line_bore_translation);
    flying_line_bore(main_line_bore_radius, main_line_bore_length, main_line_bore_x_offset);
    flying_line_bore(main_line_bore_radius, main_line_bore_length, -main_line_bore_x_offset);
}


module trim_line_bore(major_radius, minor_radius, z_translation) {
    cube_edge = 2 * (major_radius + minor_radius);
    bore_extension_length = 10 * major_radius;

    translate([0,0,z_translation])
        difference() {
            rotate([0,90,0]) {
                torus(major_radius, minor_radius);
                translate([14*major_radius,0,0])
                    torus(15*major_radius, minor_radius);
                translate([major_radius,0,0])
                    torus(2*major_radius, minor_radius);
                translate([0.5* major_radius,0,0])
                    torus(1.5*major_radius, minor_radius);
                translate([0.2* major_radius,0,0])
                    torus(1.2*major_radius, minor_radius);
            }
            translate([0,0,-0.5*cube_edge])
                cube(cube_edge,center=true);
        }
    translate([0,0,z_translation + major_radius - 0.5 * bore_extension_length]) {
        translate([0,major_radius,0])
            cylinder(h=bore_extension_length, r=minor_radius, center=true);
        translate([0,-major_radius,0])
            cylinder(h=bore_extension_length, r=minor_radius, center=true);
    }
    translate([0,0,z_translation + major_radius])
        rotate([90,0,0])
            cylinder(h=4*major_radius, r=minor_radius, center=true);

}

module flying_line_bore(radius, length, x_offset) {
    translate([x_offset,0,0])
        cylinder(h=length, r=radius, center=true);
}

module cylindrical_body(overall_width, overall_depth, overall_height, radius_of_edges) {
    major_radius = overall_width/2 - radius_of_edges;
    y_scale = overall_depth/overall_width;
    scale([1,y_scale,1]) {
        rounded_cylinder(overall_height, major_radius, radius_of_edges);
    }
}
