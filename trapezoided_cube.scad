// trapezoided_cube.scad
// Modules for generating a trapezoided cube
// Author: Philip B Chase, <philipbchase@gmail.com>
// Based on Simple and fast corned cube by Anaximandro de Godinho.

/* License: To the extent possible under law, Philip B Chase has waived all copyright and related or neighboring rights to modules to generate a trapezoided cube. This work is published from: United States.  See: http://creativecommons.org/publicdomain/zero/1.0/

Usage:

    $fn=30;

    overall_width=34;  // x
    overall_depth=38;  // y
    overall_height=12; // z

    // radii of block corners and edges
    r_base = 2;

    trapMatrixForBase = [
                        [1, 1, 1],
                        [0.7, 1, 1],
                        [1, 1, 1]
                    ];
    trapCube([overall_width, overall_depth, overall_height], trapMatrixForBase, radius=r_base, round_z_negative=false);

*/

module trapCube( size, trapMatrix=[1,1,1], radius=1, center=false, round_z_negative=true )
{
    l = len( size );
    if( l == undef )
        _trapX( size, size, size, trapMatrix, radius, center, round_z_negative );
    else
        _trapX( size[0], size[1], size[2], trapMatrix, radius, center, round_z_negative );
}

module _trapX( x, y, z, trapMatrix, r, center, round_z_negative)
{
    if( center )
        translate( [-x/2, -y/2, -z/2] )
        __trapX( x, y, z, trapMatrix, r, round_z_negative);
    else
        __trapX( x, y, z, trapMatrix, r, round_z_negative);
}

module __trapX( x, y, z, trapMatrix, r, round_z_negative)
{
    // trapezoidal matrix is defined as
    //[
    //    [scale_x, scale_in_y_along_increasing_x, scale_in_z_along_increasing_x],
    //    [scale_in_x_along_increasing_y, scale_y, scale_in_z_along_increasing_y],
    //    [scale_in_x_along_increasing_z, scale_in_y_along_increasing_z, scale_z]
    //]

    //compute deltas for each dimension
    dy_wrt_x = y * (1 - trapMatrix[0][1])/2;
    dz_wrt_x = z * (1 - trapMatrix[0][2])/2;
    dx_wrt_y = x * (1 - trapMatrix[1][0])/2;
    dz_wrt_y = z * (1 - trapMatrix[1][2])/2;
    dx_wrt_z = x * (1 - trapMatrix[2][0])/2;
    dy_wrt_z = y * (1 - trapMatrix[2][1])/2;

    // Use differing facet counts between z- and z+
    $fn_z_negative = $fn_for_negative_z(round_z_negative);

    //TODO: discount r.
    rC = r;
    hull()
    {
        //origin
        translate( [rC, rC, rC] )
            sphere( r, $fn=$fn_z_negative);
        translate( [rC+dx_wrt_y, y-rC, rC+dz_wrt_y] )
            sphere( r, $fn=$fn_z_negative );
        translate( [rC+dx_wrt_z, rC+dy_wrt_z, z-rC] )
            sphere( r );
        translate( [rC+dx_wrt_z+dx_wrt_y, y-rC-dy_wrt_z, z-rC-dz_wrt_y] )
            sphere( r );

        translate( [x-rC, rC+dy_wrt_x, rC+dz_wrt_x] )
            sphere( r, $fn=$fn_z_negative );
        translate( [x-rC-dx_wrt_y, y-rC-dy_wrt_x, rC+dz_wrt_x+dz_wrt_y] )
            sphere( r, $fn=$fn_z_negative );
        translate( [x-rC-dx_wrt_z, rC+dy_wrt_x+dy_wrt_z, z-rC-dz_wrt_x] )
            sphere( r );
        translate( [x-rC-dx_wrt_y-dx_wrt_z, y-rC-dy_wrt_x-dy_wrt_z, z-rC-dz_wrt_x-dz_wrt_y] )
            sphere( r );
    }
}

// reduce facet number to 12 if rounding is not desired
function $fn_for_negative_z(round_z_negative, $fn=12) = round_z_negative ? 30 : $fn;
