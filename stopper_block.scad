// stopper block for movable stopper

$fn=36;  // a circle has 36 sides
moveable_stopper();
//bevel(r1=10, r2=8);

// provide dimensions of block from which all other shapes are removed
$overall_width=38;  // x
$overall_depth=38;  // y
$overall_height=25; // z

// The upper half of the block is mostly cut away by a curved block
// The curved portion of this cut-away is has a radius of $cut_away_radius
// The main body of the blokc below the cut away has height $thickness_of_main_body
$cut_away_radius=8;
$thickness_of_main_body=12;

// Safety line dimensions
$safety_line_diameter=9.5;

// Cross bore for bungie dimensions
$cross_bore_diameter=8;
$cross_bore_cl_to_end=12;

// trim hole line dimensions
$trim_line_diameter=5;
$trim_line_angle=8;

// left and right cut away dimensions
$oversize=1;
$side_cutaway_height=$overall_height + 2*$oversize;

module moveable_stopper() {
    // start with a chunk of material, then chop bits off it
    // the intersection produces the curved top
    intersection(){
        // The difference is the usual method for machining something
        // We start by defining a block of material
        // And then describe a collection of bits to carve off it
        difference(){
            // this is all our material, just one block
            union(){
                cube([$overall_width,$overall_depth,$overall_height]);
            }
            // And these are all the bits we will remove
            union(){
                // The cut-away that produces the L-shape overall profile
                // This cut is a "hull", imagine three cylinders
                // covered by an elastic membrane
                // change to "#hull() {" to visualise the shape of this hull
                hull() { 
                    // aft cylinder
                    translate([0, $overall_depth - 2*$cut_away_radius, $thickness_of_main_body +$cut_away_radius])
                        rotate([0,90,0])
                            cylinder(r=$cut_away_radius,, h=$overall_width);
                    // upper cylinder
                    translate([0, $overall_depth - 2*$cut_away_radius,$overall_height])
                        rotate([0,90,0])
                            cylinder(r=$cut_away_radius, h=$overall_width);
                    // fore cylinder
                    translate([0,0,$thickness_of_main_body+$cut_away_radius])
                        rotate([0,90,0])
                            cylinder(r=$cut_away_radius, h=$overall_width);
                }
                // Safety line hole
                
                // original position
                // translate([38/2,-1,20])
                
                // position suggested by Andrew to match sketch
                translate([$overall_depth/2, -1, $safety_line_diameter/2 + $thickness_of_main_body])
                    rotate([-90,0,0])
                        union(){
                            cylinder(r=$safety_line_diameter/2, h=$overall_depth);
                            translate([0,0,$overall_depth-1])
                                bevel(r1=$safety_line_diameter/2+2, r2=$safety_line_diameter/2);
                            }

                // Cross bore for bungie
                translate([$overall_width/2,$cross_bore_cl_to_end,0])
                    rotate([0,0,0])
                        
                        union(){
                            cylinder(r=$cross_bore_diameter/2, h=$thickness_of_main_body); 
                            translate([0,0,$thickness_of_main_body - $cross_bore_diameter/2])
                                bevel(r1=$cross_bore_diameter, r2=$cross_bore_diameter/2);
                            translate([0,0,$cross_bore_diameter/2])
                                rotate([180,0,0])
                                    bevel(r1=$cross_bore_diameter, r2=$cross_bore_diameter/2);
                        }
                // left trim line hole
                translate([$thickness_of_main_body/2,-$trim_line_diameter/2,$thickness_of_main_body/2])
                    rotate([-90,0,-$trim_line_angle])
                        union(){
                            cylinder(r=$trim_line_diameter/2, h=$overall_depth + $trim_line_diameter);
                        }
                // right trim line hole
                translate([$overall_width-$thickness_of_main_body/2, -$trim_line_diameter/2, $thickness_of_main_body/2])
                    rotate([-90,0,$trim_line_angle])

                        union(){
                            cylinder(r=$trim_line_diameter/2, h=$overall_depth + $trim_line_diameter);
                        }
                // 8 degrees off left
                // The slope of the sides is defined two ways:
                // - An 8 degree slope
                // - difference between 38mm at the front and 25mm at the rear
                // For no good reason, we choose to use the 8 degree definition.
                $radius=10;
                hull(){
                    translate([-$radius,0,-$oversize])
                        rotate([0,0,0])
                            cylinder(r=$radius, h=$side_cutaway_height);
                    translate([-$radius,0,-$oversize])
                        rotate([0,0,-$trim_line_angle])
                            translate([0,$overall_depth+$oversize*3,0])
                                cylinder(r=$radius, h=$side_cutaway_height);
                }
                // 8 degrees off right
                hull(){
                    translate([$overall_width+$radius,0,-$oversize])
                        rotate([0,0,0])
                            cylinder(r=$radius, h=$side_cutaway_height);
                    translate([$overall_width+$radius,0,-$oversize])
                        rotate([0,0,$trim_line_angle])
                            translate([0,$overall_depth+$oversize*3,0])
                                cylinder(r=$radius, h=$side_cutaway_height);
                }
            }
        }
        // curve top above safety line path
        // This isn't really defined, so this is a guess
        translate([38/2,-1,13])
            hull(){
                translate([0,38/2+1,-13])
                    cube([38,38+2,13+1], center=true);  
                rotate([-90,0,0])
                    resize([38-10,(25-13)*2,38+2])
                        cylinder();
            }
            
        }
    }
    
module bevel(r1, r2){

    difference() {
        cylinder(r=r1, h=r1-r2+1, $fn=30);
        rotate_extrude(convexity = 10, $fn = 30)
            translate([r1, 0, 0])
                circle(r = r1-r2, $fn = 30);
    }
}

