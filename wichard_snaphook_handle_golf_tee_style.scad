// 3D model for a handle to release a Wichard quick release snap shackle in the "golf tee" style
// See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
// Make two pieces per snap shackle.
// Recommend this be printed in PLA with 3 shells and 80 % infill, and supports. 
// Author: Philip B Chase, <philipbchase@gmail.com>
/*
Assembly: This design is meant to be assembled on a short, folded, segment of 300# Spectra line that passes through the release gate of the snap shackle. The narrow tip of each piece faces the shackle. The spectra is folded in half, tied at the loose end and pulled through the entire assembly with a wire fid.  The folded end of the line is locked in place by a very small segment of line knotted and larksheaded on the end. The knots are recessed inside the handles.

Use: When pulled, this object pulls the opposite cone into the release gate to open the snap hook. Once released, the cone often stays in the release gate holding the gate open. This allows the gate to be reclosed with zero-force before pulling the cone out of the gate.
*/
/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to 3D model for a handle to release a Wichard quick release snap shackle. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/
*/

// The dimensions of the pull
// Dimensions of the exterior cone that enters the snaphook gate
exterior_cone_tip_r = 4.0/2;  //tip radius
exterior_cone_slope = 0.147;
exterior_cone_h = 48.76;
exterior_cone_base_r = exterior_cone_slope * exterior_cone_h + exterior_cone_tip_r;

// The dimensions of the bore that passes through the handle and cone
bore_r = 2.75/2;
bore_h = 2 * bore_r + exterior_cone_h;

// Fillet parameters
// The fillet provides a smooth transition between the cone and the base using and elliptical shape
fillet_major_radius=7;
fillet_a_axis=8;
fillet_b_axis=9;

// Base parameters
// The base is a flared end at the wide end of the cone to allow a comfortable grip when pulling
base_a_axis=9;
base_b_axis=3;
base_major_radius = 0.05;  // a non-zero radius is required for the render
underslope = tan(22);
base_underslope_height = base_b_axis - 1.75;
base_underslope_upper_radius = 2*base_a_axis+base_major_radius-1.68;
base_underslope_lower_radius = base_underslope_upper_radius - base_underslope_height/underslope;

// Base hollow
// The hollow provides a recess in the base to provide a hidden space for the line ends.
// The hollow also reduces print time and material consumption.
hollow_height = 12;
hollow_upper_radius = 3;
hollow_slope = 0.55;
hollow_lower_radius = hollow_upper_radius + hollow_height*hollow_slope; 

// set the facet number high (40-60) for final generation
$fn = 50;

difference() {
    difference () {
        union() {
            cylinder(h = exterior_cone_h, r1 = exterior_cone_base_r, r2 = exterior_cone_tip_r);
            translate([0,0,base_b_axis + 2.15])
                elliptical_cone(fillet_a_axis,fillet_b_axis, fillet_major_radius);
            translate([0,0,base_b_axis])
                elliptical_torus(base_a_axis, base_b_axis, base_major_radius);
            cylinder(h = base_underslope_height, r1 = base_underslope_lower_radius, r2 = base_underslope_upper_radius);
        }

        union() {
            translate([0,0,-bore_r])
                cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
            translate([0,0,-0.1])
                cylinder(h = hollow_height, r1 = hollow_lower_radius, r2 = hollow_upper_radius);
        }
    }
//    translate([0,exterior_cone_h/2,exterior_cone_h/2])  //a cube with one face that bisects the piece
//        cube(size=exterior_cone_h,center=true);         // uncomment this section to reveal a cross-section of the piece
}

module elliptical_cone(a_axis, b_axis, r_cone_tip){
    // a_axis is the diameter of the cone base,
    // b_axis is the cone height
    // r_cone_tip is the radius tip (top) of the cone)
    //$fn=30;
    translate([0,0,b_axis])
        rotate (a = [0,180,0])
            difference() {
                cylinder(h=b_axis, r=a_axis+r_cone_tip);

                rotate_extrude(convexity = 10)
                    translate([a_axis+r_cone_tip,0,0])
                        ellipse(a_axis, b_axis);
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
