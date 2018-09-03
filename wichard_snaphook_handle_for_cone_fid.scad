/*
3D model for a handle under a cone fid to release a Wichard quick release snap shackle.
See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
Make two pieces per snap shackle.
Recommend this be printed in PLA with 3 shells, 100 % infill with supports.
Author: Philip B Chase, <philipbchase@gmail.com>

Assembly: This design is meant to be assembled on a short, folded, segment of
    300# Spectra line that passes through the release gate of the snap
    shackle. The narrow tip of the cone fid--printed separately--faces the
    shackle. This handle sits under the cone fid. An intermediate piece
    concave faces sits in between. The spectra is folded in half, tied at the
    loose end and pulled through the entire assembly with a wire fid. The
    folded end of the line is locked in place by a very small segment of line
    knotted and larksheaded on the end.

License: To the extent possible under law, Philip B Chase has waived all
    copyright and related or neighboring rights to 3D model for a cone fid,
    link, and handle to release a Wichard quick release snap shackle. This
    work is published from: United States.
    See: http://creativecommons.org/publicdomain/zero/1.0/
*/

/*
The design of the handle

The handle is engineered in links to reduce the risk of it tensioning the line when it is pinched against the body and causing an inadvertent release.
*/

use <elliptical_torus.scad>;
use <elliptical_cone.scad>;

// Base parameters
// The base is designed to be comfortable when gripped between the first and second finger.
// The top is spherical to mate with a concave link between the handle and the cone fid.
base_diameter=30;
base_thickness = 2.5;

fillet_xy_axis = base_diameter/6;
fillet_z_axis = 2;
fillet_height = base_thickness/2 - 0.36;

spherical_cap_r=5.38;

component_height = base_thickness + fillet_z_axis + spherical_cap_r;
echo("component_height: ", component_height);

// The dimensions of the bore that passes through the handle and cone.
// The bore radius needs to be just large enough to allow a sturdy spectra
// line to pass through when doubled, yet small enough to assure the wall
// thickness at the tip is enough to not degrade in normal use.
bore_r = 2.38/2;
bore_h = 2 * bore_r + component_height;


// set the facet number high (40-60) for final generation
$fn = 50;

difference () {
    union() {
        // base
        translate([0,0,0])
            elliptical_sphere(base_diameter, base_diameter, base_thickness);
        // fillet
        translate([0,0,fillet_height])
            elliptical_cone(fillet_xy_axis, fillet_z_axis, spherical_cap_r);
        // hemispherical cap
        translate([0,0,fillet_z_axis + fillet_height])
            difference() {
                sphere(r = spherical_cap_r);
                translate([0,0,-spherical_cap_r])
                    cube(2*spherical_cap_r, center=true);
            }
    }

    // center bore
    translate([0,0,-bore_r - base_thickness/2])
        cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
}
