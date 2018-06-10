/*
3D model for a stopper block for a kite control bar.  This device works in
tandem with a stopper ball to provide variable stop position for a kite
control bar that uses a twin-trimline.

Print one piece per control bar.

Recommend this be printed in PLA with 3 shells, 80 % infill and no supports.
Author: Philip B Chase, <philipbchase@gmail.com>

Assembly with ball: This component is designed to be assemble with a stopper ball using a 1/8" bungie. The bungie should be 155mm long.  It should be routed through the small bore holes of the stopper ball and through the cross bore of the stopper block. The ends of the bungie should be blunt cut and super glued together.  The resulting bungie is a continuous loop with slightly lumpy, stiff section where the ends are glued together.

Assembly into bar: The trim line end should be routed into a trim line hole from the narrow end of the block, through the center bore of the ball, through the center bore of the bar, through, a retaining ball, back through the center bore of the bar, back through the center bore of the ball, into the remain trim line hole of the block, and out the narrow end of the block.

Use: The ball is pulled down the trim line to lower the bar stop.  The blokc is pulled up the trim line to raise the bar stop.

License: To the extent possible under law, Philip B Chase has waived all
    copyright and related or neighboring rights to 3D model for a stopper
    block for a kite control bar. This work is published from:
    United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// stopper block for movable stopper

$fn=36;  // a circle has 36 sides
//bevel(r1=10, r2=8);

// provide dimensions of block from which all other shapes are removed
overall_width=34;  // x
overall_depth=38;  // y
overall_height=25; // z

// radii of block corners and edges
r_base = 2;

// block is narrowed at the kite end
width_near_kite = overall_width * 25/38 ;

// The upper half of the block is mostly cut away by a curved block
// The curved portion of this cut-away is has a radius of cut_away_radius
// the upper portion that is not cut away has a thickness of flag_line_path_thickness
// The main body of the block below the cut away has height thickness_of_main_body
cut_away_radius=8;
flag_line_path_thickness = 6;
thickness_of_main_body=12;
upper_cylinder_offset = 1;
ratio_of_upper_section_to_lower_section_depth = 0.25;

// Safety line dimensions
safety_line_diameter=9.5;

// Cross bore for bungie dimensions
cross_bore_diameter=6;
cross_bore_cl_to_end=12;

// trim hole line dimensions
trim_line_diameter=5;
trim_line_angle=8;

// Define magnet hole
magnet_radius=3/8*25.4/2;
magnet_height=3/8*25.4 - 0.5;
distance_back_from_front = overall_depth * 0.45;

oversize=1;

moveable_stopper();

module moveable_stopper() {

    // make major trapezoidal prism
    union() {
        // Build base
        difference() {
            // Prism for Base
            trapMatrixForBase = [
                    [1, 1, 1],
                    [width_near_kite/overall_width, 1, 1],
                    [1, 1, 1]
                ];
            trapCube([overall_width, overall_depth, thickness_of_main_body], trapMatrixForBase, radius=r_base, round_z_negative=false);
            // Drill trimline holes
            trimline_holes();
            // "Drill" curved path for bungie ball connector
            bungie_ball_connector_path();
            // Drill hole for magnet
            magnet_hole();
        }
        // Upper section
        difference() {
            // Prism for Upper section
            maximum_width_of_upper_section = (width_near_kite + (overall_width - width_near_kite) * ratio_of_upper_section_to_lower_section_depth) *0.96;
            scale_in_x_along_increasing_y = width_near_kite/maximum_width_of_upper_section;
            trapMatrixForUpper = [
                [1, 1, 1],
                [scale_in_x_along_increasing_y, 1, 1],
                [.65, 1/1.618, 1]
            ];
            x_offset_of_upper_section = (overall_width - maximum_width_of_upper_section)/2 ;
            translate([x_offset_of_upper_section, overall_depth * (1-ratio_of_upper_section_to_lower_section_depth), thickness_of_main_body - 2*r_base])
                trapCube([maximum_width_of_upper_section, overall_depth * ratio_of_upper_section_to_lower_section_depth, overall_height - thickness_of_main_body +2*r_base], trapMatrixForUpper, radius=r_base, round_z_negative=true);
            // Drill trimline holes
            trimline_holes();
            // Drill flag line path
            flag_line_path();
        }
    }
}


module cut_away_upper() {
    hull() {
        // lower cylinder
        translate([0, overall_depth - cut_away_radius - flag_line_path_thickness, thickness_of_main_body +cut_away_radius])
            rotate([0,90,0])
                cylinder(r=cut_away_radius,, h=overall_width);
        // upper cylinder
        translate([0, overall_depth - cut_away_radius - flag_line_path_thickness + upper_cylinder_offset, thickness_of_main_body +cut_away_radius*2])
            rotate([0,90,0])
                cylinder(r=cut_away_radius,, h=overall_width);
    }
}

module trimline_holes(){
    x_displacement = thickness_of_main_body*0.5;
    trim_line_r = trim_line_diameter/2;
    trim_line_drill_hole_length = overall_depth + trim_line_diameter;
    // Reduce the facet count so that the upper surfaces are 22.5 degrees above horizontal.
    $fn=8;
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
            elliptical_torus(cross_bore_diameter/2, cross_bore_diameter/2, thickness_of_main_body/2 + 1);
}


module magnet_hole() {
    translate([overall_width/2, distance_back_from_front, 0])
        rotate([0,0,0])
            union() {
                cylinder(r=magnet_radius,,h=magnet_height);
                // Use a cone-shaped bottom to the magnet hole to reduce the
                // risk of print overhang issues
                translate([0,0,magnet_height])
                    cylinder(r1=magnet_radius,r2=0,h=magnet_radius*tan(25));
            }
}


module flag_line_path() {
    // Reduce the facet count so that the upper surfaces are 22.5 degrees above horizontal.
    $fn=8;
    translate([overall_width/2, -0.5, safety_line_diameter/2 + thickness_of_main_body])
        rotate([-90,0,0])
            union(){
                // define major drill hole
                cylinder(r=safety_line_diameter/2, h=overall_depth);
                //define backside bevel
                translate([0,0,overall_depth*0.95])
                    rotate([+8,0,0])
                        bevel(r1=safety_line_diameter/2+1.5, r2=safety_line_diameter/2);
                //define frontside bevel
                translate([0,0,overall_depth*(1-ratio_of_upper_section_to_lower_section_depth)*1.103])
                    rotate([+180,0,0])
                        rotate([-8,0,0])
                            bevel(r1=safety_line_diameter/2+1.5, r2=safety_line_diameter/2);
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


module elliptical_torus(a_axis, b_axis, major_radius){
    // a_axis is the width of the cross section on the X-Y plane
    // b_axis is the height of the cross section on the Z plane
    // major_radius is the radius torus
    //$fn=30;
    rotate_extrude(convexity = 10)
        translate([a_axis+major_radius,0,0])
            ellipse(a_axis, b_axis);
}

module ellipse(a_axis, b_axis) {
    scale([a_axis/a_axis,b_axis/a_axis])
        circle(r=a_axis);
}


// Trapezoided cube
// Philip Chase
// Based on Simple and fast corned cube by Anaximandro de Godinho.
module trapCube( size, trapMatrix=[1,1,1], radius=1, center=false, round_z_negative=true )
{
	l = len( size );
	if( l == undef )
		_trapX( size, size, size, trapMatrix, radius, center, round_z_negative );
	else
		_trapX( size[0], size[1], size[2], trapMatrix, radius, center, round_z_negative );
}

module _trapX( x, y, z, trapMatrix, r, center, round_z_negative)
{
    if( center )
        translate( [-x/2, -y/2, -z/2] )
        __trapX( x, y, z, trapMatrix, r, round_z_negative);
    else
        __trapX( x, y, z, trapMatrix, r, round_z_negative);
}

module __trapX(	x, y, z, trapMatrix, r, round_z_negative)
{
    // trapezoidal matrix is defined as
    //[
    //    [scale_x, scale_in_y_along_increasing_x, scale_in_z_along_increasing_x],
    //    [scale_in_x_along_increasing_y, scale_y, scale_in_z_along_increasing_y],
    //    [scale_in_x_along_increasing_z, scale_in_y_along_increasing_z, scale_z]
    //]

    //compute deltas for each dimension
    dy_wrt_x = y * (1 - trapMatrix[0][1])/2;
    dz_wrt_x = z * (1 - trapMatrix[0][2])/2;
    dx_wrt_y = x * (1 - trapMatrix[1][0])/2;
    dz_wrt_y = z * (1 - trapMatrix[1][2])/2;
    dx_wrt_z = x * (1 - trapMatrix[2][0])/2;
    dy_wrt_z = y * (1 - trapMatrix[2][1])/2;

    // Use differing facet counts between z- and z+
    $fn_z_negative = $fn_for_negative_z(round_z_negative);

	//TODO: discount r.
    rC = r;
	hull()
	{
        //origin
        translate( [rC, rC, rC] )
			sphere( r, $fn=$fn_z_negative);
		translate( [rC+dx_wrt_y, y-rC, rC+dz_wrt_y] )
			sphere( r, $fn=$fn_z_negative );
		translate( [rC+dx_wrt_z, rC+dy_wrt_z, z-rC] )
			sphere( r );
		translate( [rC+dx_wrt_z+dx_wrt_y, y-rC-dy_wrt_z, z-rC-dz_wrt_y] )
			sphere( r );

		translate( [x-rC, rC+dy_wrt_x, rC+dz_wrt_x] )
			sphere( r, $fn=$fn_z_negative );
		translate( [x-rC-dx_wrt_y, y-rC-dy_wrt_x, rC+dz_wrt_x+dz_wrt_y] )
			sphere( r, $fn=$fn_z_negative );
		translate( [x-rC-dx_wrt_z, rC+dy_wrt_x+dy_wrt_z, z-rC-dz_wrt_x] )
			sphere( r );
		translate( [x-rC-dx_wrt_y-dx_wrt_z, y-rC-dy_wrt_x-dy_wrt_z, z-rC-dz_wrt_x-dz_wrt_y] )
			sphere( r );
	}
}

// reduce facet number to 12 if rounding is not desired
function $fn_for_negative_z(round_z_negative, $fn=12) = round_z_negative ? 30 : $fn;
