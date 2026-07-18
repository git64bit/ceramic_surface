/* Replaceable transverse lock cassette with twin two-tooth pawls. */

module lock_cassette_local() {
    pawl_tooth_width = register_pitch - 2 * pawl_clearance;
    body_x = 0;

    union() {
        cube([lock_body_length, lock_body_width, lock_body_height]);

        // Narrow arms pass through protected side slots in the fixed wedge.
        translate([(lock_body_length - lock_side_arm_length) / 2,
                   -lock_body_y,
                   0])
            cube([lock_side_arm_length,
                  lock_body_y,
                  lock_tab_height]);

        translate([(lock_body_length - lock_side_arm_length) / 2,
                   lock_body_width,
                   0])
            cube([lock_side_arm_length,
                  wedge_width - lock_body_y - lock_body_width,
                  lock_tab_height]);

        // Broad external press tabs. Both tabs are pressed to release.
        translate([(lock_body_length - lock_tab_length) / 2,
                   -lock_body_y - lock_tab_projection,
                   0])
            cube([lock_tab_length,
                  lock_tab_projection,
                  lock_tab_height]);

        translate([(lock_body_length - lock_tab_length) / 2,
                   wedge_width - lock_body_y,
                   0])
            cube([lock_tab_length,
                  lock_tab_projection,
                  lock_tab_height]);

        // Two pawl teeth per rack distribute the holding load.
        for (rack_y = rack_y_positions) {
            local_y = rack_y - lock_body_y;
            for (pair_index = [0 : pawl_pairs - 1]) {
                tooth_x = pair_index * register_pitch
                        + (lock_body_length
                           - pawl_pairs * register_pitch) / 2;
                translate([0, 0, lock_body_height])
                    upward_pawl_tooth(
                        tooth_x,
                        local_y,
                        rack_width,
                        pawl_tooth_width,
                        pawl_height,
                        pawl_crest_width,
                        pawl_holding_run
                    );
            }
        }
    }
}

module lock_cassette(released = false) {
    release_drop = released ? lock_release_travel : 0;
    lock_x_start = lock_x - lock_body_length / 2;
    lock_top_at_start = fixed_base_height
                      + wedge_slope * lock_x_start
                      - central_channel_depth
                      - lock_body_top_clearance;
    lock_bottom_at_start = lock_top_at_start
                         - lock_body_height
                         - release_drop;

    translate([lock_x_start,
               lock_body_y,
               lock_bottom_at_start])
        rotate([0, -wedge_angle, 0])
            lock_cassette_local();
}

module lock_cassette_printable() {
    lock_cassette_local();
}
