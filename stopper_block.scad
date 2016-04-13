$fn=36;  // a circle has 36 sides
moveable_stopper();
//bevel(r1=10, r2=8);

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
                cube([38,38,25]);
            }
            // And these are all the bits we wil remove
            union(){
                // The cut-away that produces the L-shape overall profile
                // This cut is a "hull", imagine three cylinders
                // covered by an elastic membrane
                // change to "#hull() {" to visualise the shape of this hull
                hull() { 
                    translate([-1,38-8-8,13+8])
                        rotate([0,90,0])
                            cylinder(r=8, h=38+2);
                    translate([0,38-8-8,25])
                        rotate([0,90,0])
                            cylinder(r=8, h=38+2);
                    translate([0,0,13+8])
                        rotate([0,90,0])
                            cylinder(r=8, h=38+2);
                }
                // line hole
                
                // original position
                // translate([38/2,-1,20])
                
                // position suggested by Andrew to match sketch
                translate([38/2,-1,9.5/2+13])
                    rotate([-90,0,0])
                        union(){
                            cylinder(r=9.5/2, h=40);
                            translate([0,0,38-1])
                                bevel(r1=9.5/2+2, r2=9.5/2);
                            }
                // vertical hole
                translate([38/2,12,-1])
                    rotate([0,0,0])
                        
                        union(){
                            cylinder(r=8/2, h=40); 
                            translate([0,0,10])
                                bevel(r1=8/2+4, r2=8/2);
                                                                                     translate([0,0,5])
                                rotate([180,0,0])
                                    bevel(r1=8/2+4, r2=8/2);
                        }
                // left bolt hole
                translate([6,-1,6])
                    rotate([-90,0,-8])
                        union(){
                            cylinder(r=5/2, h=40);
                            translate([0,0,38.5])
                                bevel(r1=5/2+1.5, r2=5/2);
                            translate([0,0,2])
                                rotate([180,0,0])
                                    #bevel(r1=5/2+1.5, r2=5/2);
                        }
                // right bolt hole
                translate([38-6,-1,6])
                    rotate([-90,0,8])

                        union(){
                            cylinder(r=5/2, h=40);
                            translate([0,0,38.5])
                                bevel(r1=5/2+1.5, r2=5/2);
                            translate([0,0,2])
                                rotate([180,0,0])
                                    #bevel(r1=5/2+1.5, r2=5/2);
                        }
                // 8 degrees off left
                // The slope of the sides is defined two ways:
                // - An 8 degree slope
                // - difference between 38mm at the front and 25mm at the rear
                // For no good reason, we choose to use the 8 degree definition.
                hull(){
                    translate([-1,0,-1])
                        rotate([0,0,0])
                            cylinder(r=1, h=25+2);
                    translate([-1,0,-1])
                        rotate([0,0,-8])
                            translate([0,38,0])
                                cylinder(r=1, h=25+2);
                    translate([-1,38,-1])
                        rotate([0,0,0])
                            cylinder(r=1, h=25+2);
                }
                // 8 degrees off right
                hull(){
                    translate([38+1,0,-1])
                        rotate([0,0,0])
                            cylinder(r=1, h=25+2);
                    translate([38+1,0,-1])
                        rotate([0,0,8])
                            translate([0,38,0])
                                cylinder(r=1, h=25+2);
                    translate([38+1,38,-1])
                        rotate([0,0,0])
                            cylinder(r=1, h=25+2);
                }
            }
        }
        // curve top
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

