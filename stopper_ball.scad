// 3D model for a stopper ball for a moveable stopper assembly in a kite-bar control system
// See http://philipbchase.com/moveable-stoppers/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to be assembled into a module with a stopper block that forces a pair of kite bar trimlines to diverge and then rejoin when the enter the center bore of this stopper.  The ball and block are joined by a continuous loop of 1/8" bungie cord sized to allow about 8mm of gap between the block and ball when relaxed.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a stopper ball for a moveable stopper assembly in a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// Define major dimension of ball
ball_r = 26/2;

// Define dimension of large center bore
trimline_bore_r=5/16/2 * 25.4;
trimline_bore_length = 2 * ball_r+2;

// Define dimensions of the two small cross bores
cross_bore_r=3;
cross_bore_lateral_offset= 6 + 0.5 * (1/8*25.4);
major_radius_of_cross_bore_torus = cross_bore_lateral_offset / 2;
cross_bore_z_offset = - ball_r * 0.75;

// Define dimensions of flag lone path in terms of the trimline bore and the ball radius
flag_line_width=2*trimline_bore_r;
flag_line_path_radius=ball_r;

// Base underslope geometry
// To prevent printing issues with the overhung underside of the sphere, replace it with a cone with a 22 degree slope (or greater)
underslope = tan(30);
base_underslope_height = ball_r * 0.2;
// fatten the contact surface at the base of the cone at the bottom of
//   the ball to improve contact with raft and strength while printing
additional_radius_for_raft_contact_patch = 0.5;
base_underslope_upper_radius = sqrt(pow(ball_r,2) - pow(ball_r-base_underslope_height, 2));
echo(base_underslope_upper_radius);
base_underslope_height_revised = base_underslope_height - (ball_r - sqrt(pow(ball_r,2) - pow(trimline_bore_r, 2)));
base_underslope_lower_radius = base_underslope_upper_radius - base_underslope_height_revised/underslope + additional_radius_for_raft_contact_patch;

// set the facet number high (40-60) for final generation
$fn = 40;

difference() {
    union() {
        difference() {
            sphere(ball_r);
            // truncate underside of sphere so we can replace it with a cone.
            edge_length_of_cube = 2*ball_r;
            translate([-ball_r,-ball_r,-3*ball_r+base_underslope_height]) {
                cube([edge_length_of_cube,edge_length_of_cube,edge_length_of_cube]);
            }
        }
        translate([0,0,-ball_r])
            cylinder(h = base_underslope_height, r1 = base_underslope_lower_radius, r2 = base_underslope_upper_radius);
    }
    union() {
        cylinder(h=trimline_bore_length,r=trimline_bore_r,center=true);
        cross_bore(cross_bore_r, major_radius_of_cross_bore_torus, cross_bore_lateral_offset, cross_bore_z_offset);
        cross_bore(cross_bore_r, major_radius_of_cross_bore_torus, -cross_bore_lateral_offset, cross_bore_z_offset);
        flag_line_path(width=flag_line_width,path_r=flag_line_path_radius);    }
}


module cross_bore(minor_radius,major_radius,y_offset, z_offset) {
    translate([0,y_offset,z_offset])
        rotate(a=[90,0,0])
            torus(minor_radius,major_radius);

}


module flag_line_path(width,path_r) {
    difference() {
        translate([0.3*width,0,-0.1*width]){  // these offsets were determined through trial an error to resemble successful hand-carved pieces
            union() { // make a shicane from three 1/4 tori
                rotate(a=[90,90,0]) quarter_torus(width, path_r);
                rotate([-90,0,0]) translate([2*path_r, 0, 0]) quarter_torus(width, path_r);
                rotate([-90,0,0]) translate([0, -2*path_r, 0]) quarter_torus(width, path_r);
            }
        }
        translate([-path_r,0,0]) cube(2*path_r, center=true);
    }
}

// Because my openscad is old I have to extrude 360 degrees of torus before pruning it back.
module quarter_torus(width, path_r) {
    difference() {
        rotate_extrude()
        translate([path_r, 0, 0])
        circle(r = width/2, $fn = 100);
        union() { // remove 3/4 of the torus
            translate([path_r,path_r,0]) cube(2*path_r,center=true);
            translate([-path_r,-path_r,0]) cube(2*path_r,center=true);
            translate([path_r,-path_r,0]) cube(2*path_r,center=true);
        }
    }
}

module torus(minor_radius, major_radius){
    // minor_radius is the radius of the cross section of the torus
    // major_radius is the radius torus
    //$fn=30;
    rotate_extrude(convexity = 10)
        translate([minor_radius+major_radius,0,0])
            circle(minor_radius);
}
