// 3D model for a spinner ball for a kite-bar control system
// See http://philipbchase.com/
// Make one per kite bar
// Author: Philip B Chase, <philipbchase@gmail.com>
/* This design is meant to mate on to the pilot-end of Clamcleat® CL826-11. It fits tightly onto the end with a positive rotational lock. The spherical shape conforms t the circular hole in the kite-side of the bar and allows for easy bar spinning.  The rotational lock allows for a flag-line guide path to be reliably located opposite the cleat to reduce the risk of cleating the flag line. 
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a spinner ball for a kite-bar control system. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/

    Scans of the Clamcleat CL826-11AN are copyright Clamcleats Limited, UK
*/

use <elliptical_torus.scad>;
//$fn=16;

// Define major dimension of ball
ball_r = 26/2;

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


// Define dimension of the flag line guide path
a_axis = 1;
b_axis = 1;
major_radius = 2;

difference() {
    union() {
        half_squashed_sphere(ball_r, 0.75);
        flag_line_guide();
    }
    #cleat_end();
    #trimline_bore(trimline_bore_length, trimline_bore_r);
}

module trimline_bore(trimline_bore_length, trimline_bore_r) {
    rotate([90,0,0])
        cylinder(h=trimline_bore_length,r=trimline_bore_r,center=true);
}

module flag_line_guide() {
translate([-1 * ball_r,0,0])
    rotate([90,0,0])
        elliptical_torus(a_axis, b_axis, major_radius);
}

module cleat_end() {
  // Align the cleat with the x, y, and z axes
  translate([4,34.3,-1])
    rotate([-1,-22,-2])
      import( "/Users/pbchase/git/github/kite_bar_parts/CL826-11AN_20190212_truncated_and_hulled.stl"); 
}

module cleat() {
  // Align the cleat with the x, y, and z axes
  translate([4,34.3,-1])
    rotate([-1,-22,-2])
      import( "/Users/pbchase/git/github/kite_bar_parts/CL826-11AN_20190212_partially_truncated.stl"); 
}

module half_cube_minus_cylinder(r) {
    cube_ratio = 4;
    difference() {
        cube_minus_cylinder(r, cube_ratio);
        translate([0,-1 * cube_ratio *r,0])
            cube(2*cube_ratio*r, center=true);
    }
}

module cube_minus_cylinder(r, cube_ratio) {
    local_cube_ratio = 0.6666667 *cube_ratio;
  difference() {
      cube(2*local_cube_ratio*r, center=true);
      translate([0,0,-r]) {cylinder(h=2*r, r1=r, r2=r);}
  }
}

module half_squashed_sphere(ball_r, squash) {
    union()  {
    squashed_hemisphere(ball_r, squash);
    rotate([0,0,180])
        squashed_hemisphere(ball_r, 1.0);
    }
}


module squashed_hemisphere(radius, squash) {
    // squash will scale in x, leaving z and y unchanged
    scale([1,squash,1])
        hemisphere(radius);
}

module hemisphere(radius) {
    difference() {
        sphere(radius);
        translate([-radius-1,0,-radius-1])
           cube(radius*2+2);
    }
}