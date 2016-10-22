fillet(10, 2, false);

module fillet_around_cylinder_base(r1, r2, remove_core){
    // r1 is radius of the cylinder whose base needs a fillet around it.
    // r2 is the radius of that fillet.
    $fn=20;
    difference() {
        cylinder(r=r1 + r2, h=r2);
        union() {
            translate([0,0,r2])
                rotate_extrude(convexity = 10)
                    translate([r1 + r2, 0, 0])
                        circle(r = r2);
            if (remove_core==true) {
                cylinder(r=r1, h=r2);
            }
        }
    }
}
