/*
3D model for a cone fid for a Wichard quick release snap shackle
See http://marine.wichard.com/rubrique-Quick_release_snap_shackles-0202040300000000-ME.html
Make two pieces per snap shackle.
Recommend this be printed in PLA with 3 shells, 100 % infill and supports.
Author: Philip B Chase, <philipbchase@gmail.com>

Assembly: This design is meant to be assembled on a short, folded, segment of
    300# Spectra line that passes through the release gate of the snap
    shackle. The narrow tip of each piece faces the shackle. A handle--printed
    separately --sits below this cone fid. The spectra is folded in half, tied
    at the loose end and pulled through the entire assembly with a wire fid.
    The folded end of the line is locked in place by a very small segment of
    line knotted and larksheaded on the end.

License: To the extent possible under law, Philip B Chase has waived all
    copyright and related or neighboring rights to 3D model for a cone fid,
    link, and handle to release a Wichard quick release snap shackle. This
    work is published from: United States.
    See: http://creativecommons.org/publicdomain/zero/1.0/
*/

/*
The dimensions of the cone fid

Dimensions of the exterior cone that enters the snaphook gate. The tip radius
and taper are the most critical dimensions.  The tip diameter must be just
small enough to reliably enter the gate, but large enough to be durable as it
will receive the most wear. The taper of the cone must be steep enough to open
the gate before the tip hits to opposite side of the gate as the tip can jam
on the opposite gate. The the taper must be shallow enough that the cone
requires minimal force the open the gate.
*/
exterior_cone_tip_r = 4.0/2;  // a cone tip diameter of 4 mm allowed reliable entry into the gate in testing
exterior_cone_slope = 0.147;  // a slope of 0.147 did well in tests
// The cone height defines the overall length of the pull.  The height must
// allow two fingers to grip the base of the cone.
exterior_cone_h = 23;
exterior_cone_base_r = exterior_cone_slope * exterior_cone_h + exterior_cone_tip_r;
echo("exterior_cone_base_r: ", exterior_cone_base_r);

// The dimensions of the bore that passes through the handle and cone.
// The bore radius needs to be just large enough to allow a sturdy spectra
// line to pass through when doubled, yet small enough to assure the wall
// thickness at the tip is enough to not degrade in normal use.
bore_r = 2.38/2;
fid_height = exterior_cone_h + exterior_cone_base_r;
echo("fid_height: ", fid_height);
bore_h = 2 * bore_r + fid_height;

// set the facet number high (40-60) for final generation
$fn = 50;

difference() {
    union() {
        cylinder(h = exterior_cone_h, r1 = exterior_cone_base_r, r2 = exterior_cone_tip_r);
        sphere(r=exterior_cone_base_r);
    }
    translate([0,0,-bore_r-exterior_cone_base_r])
        cylinder(h = bore_h, r1 = bore_r, r2 = bore_r);
}
