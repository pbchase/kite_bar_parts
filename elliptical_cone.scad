r1=2;
a_axis=10;
b_axis=31;

elliptical_cone(a_axis,b_axis, r1);


module elliptical_cone(a_axis, b_axis, r_cone_tip){
    // a_axis is the diameter f the cone base,
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


module ellipse(a_axis, b_axis) {
    scale([a_axis/a_axis,b_axis/a_axis])
        circle(r=a_axis);
}