// Modules for generating an elliptical torus and an ellipse
// Author: Philip B Chase, <philipbchase@gmail.com>

/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to modules to generate an ellipse and an elliptical torus. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/

Usage:

    $fn=30;
    major_radius=7.4;
    a_axis=12;
    b_axis=6;
    elliptical_torus(a_axis, b_axis, major_radius);

or

    $fn=30;
    elliptical_sphere(10,5,1);

*/

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

module elliptical_sphere(x_thickness,y_thickness,z_thickness) {
scale([x_thickness,y_thickness,z_thickness])
    sphere(r=1);
}
