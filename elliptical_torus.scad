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

or

    torus_major_r = 10;
    torus_minor_r = 5;
    cross_sectional_r_in_plane = 4;
    cross_sectional_r_out_of_plane = 1;

    scaled_elliptical_cross_section_torus(
        torus_major_r, 
        torus_minor_r, 
        cross_sectional_r_in_plane, 
        cross_sectional_r_out_of_plane);

*/


module scaled_elliptical_cross_section_torus(
    torus_major_r, 
    torus_minor_r, 
    cross_sectional_r_in_plane, 
    cross_sectional_r_out_of_plane) {
    /*
    A module to extrude an ellipse into a torus, then scale the torus in its plane
    parameters:
        torus_major_r - the primary radius of the torus (x-axis)
        torus_minor_r - the secondary radius of the torus (y-axis)
        cross_sectional_r_in_plane - the radius of the cross section on the plane 
            of the torus. note that this radius is only true along the torus x-axis. 
            It is scaled by torus_minor_r/torus_major_r along the y-axis
        cross_sectional_r_out_of_plane - the radius of the cross section of the torus 
            out of the torus plane (z-axis)
     */

    minor_axis_rescale = torus_minor_r/torus_major_r;
        scale([1,minor_axis_rescale,1]) 
        rotate_extrude(convexity = 10)
            translate([torus_major_r,0,0])
                ellipse(cross_sectional_r_in_plane, cross_sectional_r_out_of_plane);
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

module elliptical_sphere(x_thickness,y_thickness,z_thickness) {
scale([x_thickness,y_thickness,z_thickness])
    sphere(r=0.5);
}
