/*
3D model for a stopper block for a kite control bar.  This device works in
tandem with a stopper ball to provide variable stop position for a kite
control bar that uses a twin-trimline.

Print one piece per control bar.

Recommend this be printed in PLA with 3 shells, 80 % infill, with supports. The block should be oriented with the elliptical flange down.
Author: Philip B Chase, <philipbchase@gmail.com>

Assembly with ball: This component is designed to be assemble with a stopper ball using a 1/8" bungie. The bungie should be 155mm long.  It should be routed through the small bore holes of the stopper ball and through the cross bore of the stopper block. The ends of the bungie should be blunt cut and super glued together.  The resulting bungie is a continuous loop with slightly lumpy, stiff section where the ends are glued together.

Assembly into bar: The trim line end should be routed into a trim line hole from the narrow end of the block, through the center bore of the ball, through the center bore of the bar, through, a retaining ball, back through the center bore of the bar, back through the center bore of the ball, into the remain trim line hole of the block, and out the narrow end of the block.

Use: The ball is pulled down the trim line to lower the bar stop.  The block is pulled up the trim line to raise the bar stop.

License: To the extent possible under law, Philip B Chase has waived all
    copyright and related or neighboring rights to 3D model for a stopper
    block for a kite control bar. This work is published from:
    United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// stopper block for movable stopper

use <elliptical_torus.scad>;
use <trapezoided_cube.scad>;

$fn=36;  // a circle has 36 sides

// provide dimensions of block from which all other shapes are removed
overall_width=35;  // x
overall_depth=38;  // y
thickness_of_main_body=12; // z

// radii of block corners and edges
r_base = 3;

// block is narrowed at the kite end
width_near_kite = overall_width * 21/38 ;

// Flag line dimensions
flag_line_diameter=9.5;

// Cross bore for bungie dimensions
cross_bore_depth=4;
cross_bore_width=10;
cross_bore_cl_to_end=12;

// trim hole line dimensions
trim_line_diameter=5;
trim_line_angle=12;

// Define magnet hole
magnet_radius=3/8*25.4/2;
magnet_height=3/8*25.4 - 0.5;
distance_back_from_front = overall_depth * 0.39;

// Define elliptical flange
flange_extension = 8;
flange_a_thickness = width_near_kite + 2 * flange_extension;
flange_b_thickness = thickness_of_main_body + 2 * flange_extension + 9;
elliptical_flange_thickness = 8;
flange_y_translation = (overall_depth - elliptical_flange_thickness * 0.5) + 0.4;

// note: this part was designed without the rotation shown below.
//       For redesign, consider temporarily setting rotation to zero.
rotate([-90,0,0])
    moveable_stopper();

module moveable_stopper() {

    difference() {
        union() {
            // Prism for Base
            trapMatrixForBase = [
                    [1, 1, 1],
                    [width_near_kite/overall_width, 1, 1],
                    [1, 1, 1]
                ];
            trapCube([overall_width, overall_depth, thickness_of_main_body],
                     trapMatrixForBase, radius=r_base, round_z_negative=true);
            // Elliptical flange
            difference() {
                translate([0,0,thickness_of_main_body/2])
                    translate([overall_width/2, flange_y_translation, 0])
                        rotate([90,0,0])
                            elliptical_sphere(flange_a_thickness,
                                              flange_b_thickness,
                                              elliptical_flange_thickness);

                // Drill flag line path through elliptical flange
                flag_line_path();
            }
         }

        // Drill trimline holes
        trimline_holes();

        // "Drill" curved path for bungie ball connector
        bungie_ball_connector_path();

        // Drill hole for magnet
        magnet_hole();

        // cut away a cube that reveals the tighest interior clearances
        // Uncomment this block to activate the cut away
        //scale([overall_width/2,distance_back_from_front,overall_width/2])
        //    cube(size=1);
    }
}

module trimline_holes(){
    x_displacement = thickness_of_main_body*0.5;
    trim_line_r = trim_line_diameter/2;
    trim_line_drill_hole_length = overall_depth + trim_line_diameter;
    // Reduce the facet count so that the upper surfaces are 22.5 degrees above horizontal.
    // Drill left trim line hole
    translate([x_displacement,-trim_line_r,x_displacement])
        rotate([-90,0,-trim_line_angle])
            cylinder(r=trim_line_r, h=trim_line_drill_hole_length);
    // Drill right trim line hole
    translate([overall_width - x_displacement, -trim_line_r, x_displacement])
        rotate([-90,0,trim_line_angle])
            cylinder(r=trim_line_r, h=trim_line_drill_hole_length);
}


 module bungie_ball_connector_path() {
    translate([overall_width/2,-1.5,thickness_of_main_body/2])
        rotate([0,90,0])
            elliptical_torus(cross_bore_depth/2, cross_bore_width/2, thickness_of_main_body/2 + 1);
}


module magnet_hole() {
    translate([overall_width/2, distance_back_from_front, 0])
        rotate([0,0,0])
            cylinder(r=magnet_radius,,h=magnet_height);
}


module flag_line_path() {
    translate([overall_width/2, 0, flag_line_diameter/2 + thickness_of_main_body])
        rotate([-90,0,0])
            union(){
                // define major drill hole
                cylinder(r=flag_line_diameter/2, h=overall_depth);
                //define backside bevel
                translate([0,0,flange_y_translation+elliptical_flange_thickness*0.18])
                    rotate([+11,0,0])
                        bevel(r1=flag_line_diameter/2+1.5, r2=flag_line_diameter/2);
                //define frontside bevel
                translate([0,0,flange_y_translation-elliptical_flange_thickness*0.18])
                    rotate([+180,0,0])
                        rotate([-11,0,0])
                            bevel(r1=flag_line_diameter/2+1.5, r2=flag_line_diameter/2);
            }
}

module bevel(r1, r2){
    difference() {
        cylinder(r=r1, h=r1-r2+1, $fn=30);
        rotate_extrude(convexity = 10, $fn = 30)
            translate([r1, 0, 0])
                circle(r = r1-r2, $fn = 12);
    }
}

