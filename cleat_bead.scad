// 3D model for a cleat bead for a kite-bar control system
// See http://philipbchase.com/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to mate on to the pilot-end of Clamcleat® CL826-11. It fits tightly onto the end with a positive rotational lock. The spherical shape conforms to the circular hole in the kite-side of the bar and allows for easy bar spinning.  The rotational lock allows for a flag-line guide path to be routed away from the jaws of the cleat to reduce the risk of cleating the flag line.
*/
// Version: 3.0.0
// File: cleat_bead.scad
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a cleat bead for a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/

    Scans of the Clamcleat CL826-11AN are copyright Clamcleats Limited, UK
*/

use <elliptical_torus.scad>;
use <fillet_around_cylinder_base.scad>;
$fn=40;

// Define major dimension of ball
ball_r = 27/2;
hemisphere_squash_ratio = 0.75;
bead_center_to_back_face = -14;
edge_radius = 1;

// Define dimension of large center bore for the pair of trim lines
// The line diameters here have all been tested using a wrap of insignia cloth
// around the line end to provide a threading end. This slightly increases the
// line diameter, but is very helpful for routing the line through the
// stopper and ball. In each case, the width of the cloth wrapped around the
// line as 4 times the nominal line diameter. Aka, slightly more than Pi and
// slightly more than one wrap.
bore_diameter_for_4mm_amsteel = 1/4 * 25.4;
bore_diameter_for_old_5mm_amsteel = 5/16 * 25.4;
bore_diameter_for_modern_5mm_amsteel = 3/8 * 25.4;
bore_diameter_for_5mm_ultrex = 3/8 * 25.4;
trim_line_diameter=bore_diameter_for_old_5mm_amsteel;

trimline_bore_r=trim_line_diameter/2;
trimline_bore_length = 2 * ball_r+2;
bore_campher_radius = 4.0;
bore_campher_height = 3;

// Define dimensions of flag line path in terms of the trimline bore and the ball radius
flag_line_width=bore_diameter_for_modern_5mm_amsteel;
flag_line_path_radius=ball_r;
flag_line_guide_radius=flag_line_width/2 + 2;

// Define dimension of the flag line guide path
flag_line_path_straight_segment_length = -bead_center_to_back_face;

// Define Set screw dimensions
set_screw_radius = 2;
set_screw_length = 12;
set_screw_height_above_base = 7;

// define cross sectional view parameters
cross_section_edge = 100;

// Rotate the kite side down for easier printing
    rotate([90,0,145])
    difference() {
        cleat_bead_without_flag_line_path();
        flag_line_path(flag_line_width, flag_line_path_radius,flag_line_path_straight_segment_length);
        campher_trimline_bore(ball_r, trimline_bore_r, bore_campher_radius, bore_campher_height);
        //cross_section(cross_section_edge);
        //#cleat();
    }

module cleat_bead_without_flag_line_path() {
   difference() {
        hull() {
            sphere(r=ball_r);
            flag_line_guide(flag_line_guide_radius, 
                flag_line_path_radius, 
                ball_r, 
                bead_center_to_back_face);
            cleat_end_slice(bead_center_to_back_face);
            expand_back_face(edge_radius, bead_center_to_back_face);
       }
       cleat_end();
       trimline_bore(trimline_bore_length, trimline_bore_r);
       set_screw(set_screw_radius, set_screw_length);
    }
}

module rope_volume_on_right_side_of_cleat() {
    translate([-3,-21,6.5])
        rotate([1,-5,-17])
            scale([6.5,16,5])
                sphere(r=1);
}

module campher_trimline_bore(ball_r, trimline_bore_r, bore_campher_radius, bore_campher_height) {
    translate([0,ball_r-bore_campher_radius + 4.6,0])
        rotate([90,0,0])
            union() {
                fillet_around_cylinder_base(trimline_bore_r, bore_campher_radius, true);
                translate([0,0,-1.5])
                    cylinder(h=bore_campher_height, r=trimline_bore_r+bore_campher_radius, center=true);
            }
}

module cross_section(cross_section_edge) {
    rotate([0,-45,0])
        translate([-cross_section_edge/2,-cross_section_edge/2,0])
            cube(cross_section_edge);
}

module expand_back_face(edge_radius, bead_center_to_back_face) {
    y_disp = bead_center_to_back_face + edge_radius;
    translate([-6.6,y_disp,1.6]) rotate([90,0,0]) elliptical_torus(edge_radius, edge_radius, 5.2);
    translate([-2.0,y_disp,3.5]) rotate([90,0,0]) elliptical_torus(edge_radius, edge_radius, 7.4);
}

module flag_line_path(width,path_r,flag_line_path_straight_segment_length) {
    translate([0,0,0])
    rotate([-90,135,0])
        union() { // make a cylinder with a 1/4 torus end
                rotate(a=[90,90,0]) quarter_torus(width, path_r);
                translate([path_r, 0, -0.5*flag_line_path_straight_segment_length])
                    union() {
                        cylinder(h=1.0004 * flag_line_path_straight_segment_length, r=width/2, center=true);
                        translate([0,0,-0.5002*flag_line_path_straight_segment_length])
                            fillet_around_cylinder_base(width/2, 1, true);
                    }
        }
}

module flag_line_guide(radius, flag_line_path_radius, ball_r, bead_center_to_back_face) {
    torus_minor_r=1;
    rotate([0,45,0]) {
        // shape the front with a half-sphere
        translate([0,bead_center_to_back_face + radius,-flag_line_path_radius])
            difference() {
                sphere(radius);
                rotate([90,0,0])
                    cylinder(h=radius, r=radius);
            }
        // Place a torus at the back face.
        translate([0, bead_center_to_back_face + torus_minor_r,-flag_line_path_radius])
            rotate([90,0,0])
                elliptical_torus(torus_minor_r, torus_minor_r, radius - 2*torus_minor_r);
    }
}

module trimline_bore(trimline_bore_length, trimline_bore_r) {
    rotate([90,0,0])
        cylinder(h=trimline_bore_length,r=trimline_bore_r,center=true);
}

module set_screw(set_screw_radius, set_screw_length) {
    translate([0, set_screw_height_above_base - ball_r, 10])
            cylinder(h=set_screw_length,r=set_screw_radius,center=true);
}

module cleat_end_slice(bead_center_to_back_face) {
    slice_thickness = 1;
    slice_edge_radius = 1;
    minkowski() {
        intersection() {
            cleat_end();
            translate([0,bead_center_to_back_face + slice_edge_radius + slice_thickness/2,0]) cube([20,slice_thickness,20], center=true);
        }
        sphere(r=slice_edge_radius);
    }
}

module cleat_end() {
  // Align the cleat with the x, y, and z axes
  translate([0,4,0])
  union() {
      translate([4,34.3,-1])
        rotate([-1,-22,-2])
          import( "CL826-11AN_20190212_truncated_and_hulled.stl");
      rope_volume_on_right_side_of_cleat();
  }
}

module cleat() {
  // Align the cleat with the x, y, and z axes
  translate([0,4,0])
  translate([4,34.3,-1])
    rotate([-1,-22,-2])
      import( "CL826-11AN_20190212_partially_truncated.stl");
}

// Because my openscad is old I have to extrude 360 degrees of torus before pruning it back.
module quarter_torus(width, path_r) {
    difference() {
        rotate_extrude()
        translate([path_r, 0, 0])
        circle(r = width/2, $fn = 15);
        union() { // remove 3/4 of the torus
            translate([path_r,path_r,0]) cube(2*path_r,center=true);
            translate([-path_r,-path_r,0]) cube(2*path_r,center=true);
            translate([path_r,-path_r,0]) cube(2*path_r,center=true);
        }
    }
}
