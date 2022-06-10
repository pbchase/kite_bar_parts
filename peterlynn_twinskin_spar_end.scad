// 3D model for a Peter Lynn Twinskin Spar End
// These spar ends are designed the replace the factory-supplied spar ends commonly used in the Peter Lynn Twinskin series kites manufactured by Vliegerop. 
// Make four per kite
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This component functions as a replacement for the factory-supplied spar end in the blue, 12.5 mm OD spars supplied with the Peter Lynn Twinskin series kites manufactured by Vliegerop. The kites that use these spars are the Venom, Vortex, Venom II, Scorpion, Synergy, Charger, Phantom II, and Charger II. One should be used at each end of a blue, 12.5mm OD aluminum spar as found in a Peter Lynn Twinskin. Each end of the internal bungie cord should be passed through the cross bore and tied off. The reduce diamter of the main body should slide into the spar end. The domed end should keep the spar end from going any further inside the spar. The dome protects end of the fabric pocket from the end of the spar. This reduces the risk of the spar punching through the pocket in a nose-down crash. 

    This component should be printed with 100% infill.

*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a Peter Lynn Twinskin Spar End. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

use <rounded_cylinder.scad>;

$fn=60;

// Body dimensions
id_od_interference = 0.15;
overall_width = 11 - id_od_interference;  // x
overall_depth = overall_width;  // y
overall_major_radius = overall_width / 2;
overall_height = 20; // z
// radii of block corners and edges
r_body = 2.5;


cross_bore_radius = 5.0 / 2;
cross_bore_torus_major_radius = 0.375 * overall_width;
cross_bore_z_offset = 0.35 * overall_height - cross_bore_radius + cross_bore_torus_major_radius; 

pin_bore_length = overall_depth + 2;
pin_bore_z_offset = 0.35 * overall_height - cross_bore_radius;

// interior bevel dimensions
bevel_size_x = overall_width;
bevel_size_y = overall_width;
bevel_size_z = 0.5 * overall_height;
bevel_y_offset = 1.0 * overall_width;
bevel_z_offset = 0.18 * overall_height;
bevel_x_rotation = 30;

// cap dimensions
cap_overall_width = 12.5;
cap_major_radius = cap_overall_width / 2 ;
cap_overall_height = 4;
cap_radius_of_edges = 3;

difference() {
    half_rounded_cylinder(overall_height, overall_major_radius, r_body);
    pin_bore(cross_bore_radius, pin_bore_length, pin_bore_z_offset);
    cross_bore(cross_bore_torus_major_radius, cross_bore_radius, cross_bore_z_offset);
    interior_bevel(bevel_size_x, bevel_size_y, bevel_size_z, bevel_z_offset, bevel_y_offset, bevel_x_rotation, 0);
    interior_bevel(bevel_size_x, bevel_size_y, bevel_size_z, bevel_z_offset, bevel_y_offset, bevel_x_rotation, 180);
}

cap(cap_overall_height, cap_major_radius, cap_radius_of_edges, overall_height);

module cross_bore(cross_bore_torus_major_radius, cross_bore_radius, cross_bore_z_offset) {
    translate([0,0,cross_bore_z_offset])
        rotate([0,90,0])
            torus(cross_bore_torus_major_radius, cross_bore_radius);
}

module cap(cap_overall_height, cap_major_radius, cap_radius_of_edges, overall_height) {
    translate([0,0,-0.5 * overall_height - 0.5 * cap_overall_height])
        rotate([180,0,0])
            half_rounded_cylinder(cap_overall_height, cap_major_radius, cap_radius_of_edges);
}

module interior_bevel(bevel_size_x, bevel_size_y, bevel_size_z, bevel_z_offset, bevel_y_offset, bevel_x_rotation, z_rotation) {
    rotate([bevel_x_rotation,0,z_rotation])
        translate([0,bevel_y_offset,bevel_z_offset])
            cube([bevel_size_x, bevel_size_y, bevel_size_z], center=true);
}

module pin_bore(radius, length, z_offset) {
    translate([0,0,z_offset])
        rotate([90,0,0])
            cylinder(h=length, r=radius, center=true);
}
