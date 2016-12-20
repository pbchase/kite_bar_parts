// 3D model for a stopper ball for a moveable stopper assembly in a kite-bar control system
// See http://philipbchase.com/moveable-stoppers/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to be assembled into a module with a stopper block that forces a pair of kite bar trimlines to diverge and then rejoin when the enter the center bore of this stopper.  The ball and block are joined by a continuous loop of 1/8" bungie cord sized to allow about 8mm of gap between the block and ball when relaxed.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a stopper ball for a moveable stopper assembly in a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// Define major dimension of ball
ball_r = 7/8/2 * 25.4;

// Define dimension of large center bore
trimline_bore_r=5/16/2 * 25.4;
trimline_bore_length = 2 * ball_r;

// Define dimensions of the two small cross bores
cross_bore_r=1/8/2 * 25.4;
cross_bore_l=2 * ball_r;
cross_bore_lateral_offset= 0.75 * ball_r;

// Define dimensions of flag lone path in terms of the trimline bore and the ball radius
flag_line_width=2*trimline_bore_r;
flag_line_path_radius=ball_r;


// set the facet number high (40-60) for final generation
$fn = 50;

difference() {
    sphere(ball_r);
    union() {
        cylinder(h=trimline_bore_length,r=trimline_bore_r,center=true);
        cross_bore(cross_bore_r, cross_bore_l, cross_bore_lateral_offset);
        cross_bore(cross_bore_r, cross_bore_l, -cross_bore_lateral_offset);
        flag_line_path(width=flag_line_width,path_r=flag_line_path_radius);    }
}


module cross_bore(r,l,offset) {
    rotate(a=[0,90,0]) {
        translate([0,offset,0]) {
            cylinder(h=l,r=r,center=true);
        }
    }    
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
