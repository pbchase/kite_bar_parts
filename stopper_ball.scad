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

// Define torus which will form the base of the sphere via a hull
base_major_r = ball_r * 0.42;
base_minor_r = ball_r * 0.075;

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
trim_line_diameter=bore_diameter_for_modern_5mm_amsteel;

trimline_bore_r=trim_line_diameter/2;
trimline_bore_length = 2 * ball_r+2;

// Define dimensions of the two small cross bores
cross_bore_r=3;
cross_bore_lateral_offset= 6.5 + 0.5 * (1/8*25.4);
major_radius_of_cross_bore_torus = cross_bore_lateral_offset / 2;
cross_bore_z_offset = - ball_r * 0.75;

// Define dimensions of flag lone path in terms of the trimline bore and the ball radius
flag_line_width=2*trimline_bore_r;
flag_line_path_radius=ball_r;

// set the facet number high (40-60) for final generation
$fn = 40;

difference() {
    // make the body
    hull() {
        sphere(ball_r);
        base(base_major_r, base_minor_r, ball_r);
    }
    // cut away all everything in this union
    union() {
        cylinder(h=trimline_bore_length,r=trimline_bore_r,center=true);
        cross_bore(cross_bore_r, major_radius_of_cross_bore_torus, cross_bore_lateral_offset, cross_bore_z_offset);
        cross_bore(cross_bore_r, major_radius_of_cross_bore_torus, -cross_bore_lateral_offset, cross_bore_z_offset);
        flag_line_path(width=flag_line_width,path_r=flag_line_path_radius);
        // uncomment either or both of these line to reveal the tight internal clearances
        //cut_away_on_yz_plane();
        //cut_away_on_xz_plane();
    }
}


module base(major_radius, minor_radius, ball_r) {
    translate([0,0,-ball_r+minor_radius])
        torus(minor_radius,major_radius);
}


module cross_bore(minor_radius,major_radius,y_offset, z_offset) {
    translate([0,y_offset,z_offset])
        rotate(a=[90,0,0])
            torus(minor_radius,major_radius);

}


module flag_line_path(width,path_r) {
    difference() {
        translate([0.3*width,0,-0.1*width]){  // these offsets were determined through trial and error to resemble successful hand-carved pieces
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
        circle(r = width/2, $fn = 30);
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

module cut_away_on_yz_plane() {
    translate([0,-ball_r,-ball_r])
        scale([ball_r,2*ball_r,2*ball_r])
            cube();
}

module cut_away_on_xz_plane() {
    translate([-ball_r,cross_bore_lateral_offset,-ball_r])
        scale([2*ball_r,2*ball_r,2*ball_r])
            cube();
}
