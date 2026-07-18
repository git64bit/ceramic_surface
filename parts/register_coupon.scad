/* Short printable register test pieces for clearance and tooth evaluation. */

coupon_length = 90;
coupon_width = 24;
coupon_base = 8;

module coupon_rack() {
    union() {
        cube([coupon_length, coupon_width, coupon_base]);
        downward_register_rack(
            coupon_length,
            5,
            rack_width,
            register_pitch,
            5,
            rack_depth,
            0,
            rack_crest_width,
            rack_holding_run,
            rack_root_chamfer
        );
    }
}

module coupon_pawl() {
    body_length = 34;
    union() {
        cube([body_length, coupon_width, 6]);
        for (pair_index = [0 : 1]) {
            tooth_x = 7 + pair_index * register_pitch;
            translate([0, 0, 6])
                upward_pawl_tooth(
                    tooth_x,
                    5,
                    rack_width,
                    register_pitch - 2 * pawl_clearance,
                    pawl_height,
                    pawl_crest_width,
                    pawl_holding_run
                );
        }
    }
}

module coupon_channel() {
    difference() {
        cube([coupon_length, 40, 12]);
        translate([4, 8, 6])
            cube([coupon_length - 8, 24, 8]);
    }
}

module register_coupon() {
    coupon_channel();
    translate([0, 48, coupon_base])
        rotate([180, 0, 0])
            coupon_rack();
    translate([105, 8, 0])
        coupon_pawl();
}
