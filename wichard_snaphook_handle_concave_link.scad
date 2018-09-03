/*
3D model for a concave link between a cone fid and a handle to release a Wichard quick release snap shackle.
See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
Make two pieces per snap shackle.
Recommend this be printed in PLA with 3 shells, 100 % infill with supports.
Author: Philip B Chase, <philipbchase@gmail.com>

Assembly: This design is meant to be assembled on a short, folded, segment of
    300# Spectra line that passes through the release gate of the snap shackle.
    The narrow tip of the cone fid--printed separately--faces the shackle. This link sits under the cone fid burt above the handle. 
    The spectra is folded in half,
    tied at the loose end and pulled through the entire assembly with a wire fid.
    The folded end of the line is locked in place by a very small segment of line
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

// Base parameters
// The base is designed to be comfortable when gripped between the first and second finger.
// The top is spherical to mate with a concave link between the handle and the cone fid.
link_height = 6;
spherical_cap_r=5.38;
link_radius = spherical_cap_r;
center_to_center_sphere_spacing = link_height * 1.8;

// The dimensions of the bore that passes through the handle and cone.
// The bore radius needs to be just large enough to allow a sturdy spectra
// line to pass through when doubled, yet small enough to assure the wall
// thickness at the tip is enough to not degrade in normal use.
bore_r = 2.38;
bore_h = 2 * bore_r + link_height;


// set the facet number high (40-60) for final generation
$fn = 50;

difference () {
    // cylindrical body
    cylinder(h = link_height, r1 = link_radius, r2 = link_radius, center=true);
    // upper concavity
    translate([0,0,center_to_center_sphere_spacing/2])
        sphere(r=spherical_cap_r);
    // lower concavity
    translate([0,0,-center_to_center_sphere_spacing/2])
        sphere(r=spherical_cap_r);
    // center bore 
    translate([0,0,-bore_r])
        cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
}
