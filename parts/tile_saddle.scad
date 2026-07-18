/*
  Universal TPU ceramic-edge saddle and rigid PLA+ datum insert.

  Assembly coordinates:
    X = insertion depth from the ceramic edge toward the tile centre
    Y = distance along the ceramic edge
    Z = tile thickness direction

  The tile enters from +X. The rigid insert is on the lower datum side.
  Flip the complete saddle assembly to use the datum insert above the tile.
*/

module saddle_grip_rib(y_center, depth = saddle_depth) {
    rib_x_end = min(saddle_grip_rib_x_end, depth - 2);
    points = [
        [saddle_grip_rib_x_start, saddle_tile_gap],
        [rib_x_end, saddle_tile_gap],
        [rib_x_end, saddle_tile_gap - saddle_grip_rib_height],
        [saddle_grip_rib_x_full,
         saddle_tile_gap - saddle_grip_rib_height]
    ];

    extrude_xz(
        points,
        y_center - saddle_grip_rib_width / 2,
        saddle_grip_rib_width
    );
}

module saddle_corner_reliefs(length = saddle_length,
                             depth = saddle_depth,
                             gap = saddle_tile_gap) {
    relief_length = length + 2;

    // The grooves keep ceramic edge radii and glaze buildup away from
    // the two precision face-contact regions.
    translate([-0.20, -1, 0])
        cylinder_y(relief_length, saddle_corner_relief_diameter);

    translate([-0.20, -1, gap])
        cylinder_y(relief_length, saddle_corner_relief_diameter);
}

module saddle_datum_window() {
    translate([
        saddle_datum_window_x,
        saddle_datum_window_y,
        -saddle_jaw_thickness - 0.20
    ])
        cube([
            saddle_datum_window_width,
            saddle_datum_window_length,
            saddle_jaw_thickness + 0.60
        ]);
}

module saddle_insert_guides() {
    guide_y_start = saddle_insert_y - 1;
    guide_length = saddle_insert_length + 3;
    guide_bottom = -saddle_jaw_thickness - saddle_guide_drop;
    guide_height = saddle_guide_drop;
    left_outer_x = saddle_insert_center_x
                 - saddle_insert_flange_width / 2
                 - saddle_guide_wall;
    right_outer_x = saddle_insert_center_x
                  + saddle_insert_flange_width / 2;
    left_lip_x = saddle_insert_center_x
               - saddle_insert_deck_width / 2
               - saddle_guide_lip_width;
    right_lip_x = saddle_insert_center_x
                + saddle_insert_deck_width / 2;

    // Side guide walls retain the PLA+ flange during handling.
    translate([left_outer_x, guide_y_start, guide_bottom])
        cube([saddle_guide_wall, guide_length, guide_height]);

    translate([right_outer_x, guide_y_start, guide_bottom])
        cube([saddle_guide_wall, guide_length, guide_height]);

    // Lower lips capture the flange but do not lie in the compressive
    // datum load path between ceramic and the insert's external deck.
    translate([
        left_lip_x,
        guide_y_start,
        guide_bottom
    ])
        cube([
            saddle_guide_lip_width,
            guide_length,
            saddle_guide_lip_thickness
        ]);

    translate([
        right_lip_x,
        guide_y_start,
        guide_bottom
    ])
        cube([
            saddle_guide_lip_width,
            guide_length,
            saddle_guide_lip_thickness
        ]);

    // Closed far end establishes repeatable insertion depth.
    translate([
        left_outer_x,
        saddle_insert_y + saddle_insert_length + 1,
        guide_bottom
    ])
        cube([
            right_outer_x + saddle_guide_wall - left_outer_x,
            saddle_guide_stop_thickness,
            guide_height
        ]);

    // Opposed TPU detents engage reliefs in the PLA+ flange. They retain
    // the unloaded insert during handling but release by pulling the tab.
    detent_z = -saddle_jaw_thickness
              - saddle_insert_slide_clearance
              - saddle_insert_flange_height
              + 0.40;
    translate([
        left_outer_x + saddle_guide_wall,
        saddle_guide_detent_y,
        detent_z
    ])
        cube([
            saddle_guide_detent_projection,
            saddle_guide_detent_length,
            saddle_guide_detent_height
        ]);

    translate([
        right_outer_x - saddle_guide_detent_projection,
        saddle_guide_detent_y,
        detent_z
    ])
        cube([
            saddle_guide_detent_projection,
            saddle_guide_detent_length,
            saddle_guide_detent_height
        ]);
}

module tpu_saddle_body() {
    difference() {
        union() {
            // Ceramic edge wall.
            translate([
                -saddle_back_wall,
                0,
                -saddle_jaw_thickness
            ])
                cube([
                    saddle_back_wall,
                    saddle_length,
                    saddle_tile_gap + 2 * saddle_jaw_thickness
                ]);

            // Lower datum-side jaw.
            translate([0, 0, -saddle_jaw_thickness])
                cube([
                    saddle_depth,
                    saddle_length,
                    saddle_jaw_thickness
                ]);

            // Opposing compliant jaw.
            translate([0, 0, saddle_tile_gap])
                cube([
                    saddle_depth,
                    saddle_length,
                    saddle_jaw_thickness
                ]);

            for (rib_y = saddle_grip_rib_y_positions)
                saddle_grip_rib(rib_y);

            saddle_insert_guides();
        }

        saddle_corner_reliefs();
        saddle_datum_window();

        // Small drainage/inspection openings at the closed edge.
        for (drain_y = [18, saddle_length - 18])
            translate([
                -saddle_back_wall - 1,
                drain_y,
                saddle_tile_gap / 2
            ])
                cylinder_x(
                    saddle_back_wall + 3,
                    saddle_drain_diameter
                );
    }
}

module pla_datum_insert_local() {
    boss_width = saddle_datum_window_width
               - 2 * saddle_insert_slide_clearance;
    boss_length = saddle_datum_window_length
                - 2 * saddle_insert_slide_clearance;
    boss_x = saddle_insert_center_x - boss_width / 2;
    boss_y = saddle_datum_window_y
           + saddle_insert_slide_clearance
           - saddle_insert_y;
    boss_height = saddle_jaw_thickness
                + saddle_insert_slide_clearance
                + saddle_datum_contact_proud;
    actual_flange_width = saddle_insert_flange_width
                         - 2 * saddle_insert_slide_clearance;
    actual_deck_width = saddle_insert_deck_width
                      - 2 * saddle_insert_slide_clearance;
    flange_x = saddle_insert_center_x
             - actual_flange_width / 2;
    deck_x = saddle_insert_center_x
           - actual_deck_width / 2;

    difference() {
        union() {
            // External rigid deck. Future station adapters attach here.
            translate([deck_x, 0, 0])
                cube([
                    actual_deck_width,
                    saddle_insert_length,
                    saddle_insert_deck_height
                ]);

            // Captured flange slides between the TPU guide rails.
            translate([
                flange_x,
                0,
                saddle_insert_deck_height
                - saddle_insert_flange_height
            ])
                cube([
                    actual_flange_width,
                    saddle_insert_length,
                    saddle_insert_flange_height
                ]);

            // This boss passes through the TPU jaw and directly contacts
            // the ceramic face, bypassing TPU in the precision load path.
            translate([
                boss_x,
                boss_y,
                saddle_insert_deck_height
            ])
                cube([
                    boss_width,
                    boss_length,
                    boss_height
                ]);

            // Pull tab remains accessible at the open end of the guides.
            translate([
                saddle_insert_center_x
                - saddle_insert_pull_width / 2,
                -saddle_insert_pull_length,
                0
            ])
                cube([
                    saddle_insert_pull_width,
                    saddle_insert_pull_length,
                    saddle_insert_pull_thickness
                ]);
        }

        // Shallow side reliefs receive the TPU guide detents at full
        // insertion. The detents are retention features, not load paths.
        translate([
            flange_x - 0.10,
            saddle_guide_detent_y,
            saddle_insert_deck_height
            - saddle_insert_flange_height - 0.10
        ])
            cube([
                saddle_guide_detent_projection + 0.45,
                saddle_guide_detent_length + 0.30,
                saddle_insert_flange_height + 0.20
            ]);

        translate([
            flange_x + actual_flange_width
            - saddle_guide_detent_projection - 0.35,
            saddle_guide_detent_y,
            saddle_insert_deck_height
            - saddle_insert_flange_height - 0.10
        ])
            cube([
                saddle_guide_detent_projection + 0.45,
                saddle_guide_detent_length + 0.30,
                saddle_insert_flange_height + 0.20
            ]);

        // Two large future attachment holes keep this insert useful while
        // attachment adapters are still being developed.
        for (hole_y = [30, saddle_insert_length - 30])
            translate([
                saddle_insert_center_x,
                hole_y,
                -1
            ])
                cylinder(
                    h = saddle_insert_deck_height + 2,
                    d = saddle_insert_attachment_hole
                );
    }
}

module pla_datum_insert_assembly() {
    insert_assembly_z = -saddle_jaw_thickness
                      - saddle_insert_slide_clearance
                      - saddle_insert_deck_height;

    translate([
        0,
        saddle_insert_y,
        insert_assembly_z
    ])
        pla_datum_insert_local();
}

module saddle_tile_preview() {
    color([0.82, 0.82, 0.78, 0.72])
        translate([0, 0, 0])
            cube([
                saddle_preview_tile_depth,
                saddle_length,
                preview_tile_thickness
            ]);
}

module saddle_assembly(show_tile = true) {
    if (show_tile)
        saddle_tile_preview();

    color([0.20, 0.55, 0.76, 0.82])
        tpu_saddle_body();

    color([0.92, 0.48, 0.16])
        pla_datum_insert_assembly();

    echo(str("Saddle nominal tile gap: ", saddle_tile_gap, " mm"));
    echo(str("Effective grip gap at rib: ",
             saddle_tile_gap
             - saddle_grip_rib_height
             - saddle_datum_contact_proud,
             " mm"));
}

module tpu_saddle_printable() {
    // Rotate so the ceramic opening faces upward and the broad edge wall
    // forms the print-bed datum. This minimizes unsupported TPU bridging.
    translate([0, 0, saddle_back_wall])
        rotate([0, -90, 0])
            tpu_saddle_body();
}

module tile_fit_coupon(gap_offset = 0, mark_count = 1) {
    coupon_gap = preview_tile_thickness
               + saddle_tile_gap_clearance
               + gap_offset
               - saddle_datum_contact_proud;
    coupon_length = saddle_fit_coupon_length;
    coupon_depth = saddle_fit_coupon_depth;

    difference() {
        union() {
            translate([
                -saddle_back_wall,
                0,
                -saddle_jaw_thickness
            ])
                cube([
                    saddle_back_wall,
                    coupon_length,
                    coupon_gap + 2 * saddle_jaw_thickness
                ]);

            translate([0, 0, -saddle_jaw_thickness])
                cube([
                    coupon_depth,
                    coupon_length,
                    saddle_jaw_thickness
                ]);

            translate([0, 0, coupon_gap])
                cube([
                    coupon_depth,
                    coupon_length,
                    saddle_jaw_thickness
                ]);

            // One rib uses exactly the same profile as the full saddle.
            points = [
                [saddle_grip_rib_x_start, coupon_gap],
                [coupon_depth - 2, coupon_gap],
                [coupon_depth - 2,
                 coupon_gap - saddle_grip_rib_height],
                [min(saddle_grip_rib_x_full, coupon_depth - 6),
                 coupon_gap - saddle_grip_rib_height]
            ];
            extrude_xz(
                points,
                (coupon_length - saddle_grip_rib_width) / 2,
                saddle_grip_rib_width
            );
        }

        saddle_corner_reliefs(coupon_length, coupon_depth, coupon_gap);

        // One, two or three edge notches identify tight, nominal and loose.
        for (mark_index = [0 : mark_count - 1])
            translate([
                -saddle_back_wall - 1,
                4 + mark_index * 6,
                coupon_gap + saddle_jaw_thickness - 2.5
            ])
                cube([saddle_back_wall + 3, 3, 4]);
    }
}

module saddle_fit_set_printable() {
    fit_offsets = [
        saddle_fit_tight_offset,
        saddle_fit_nominal_offset,
        saddle_fit_relaxed_offset
    ];

    translate([0, 0, saddle_back_wall])
        rotate([0, -90, 0])
            for (fit_index = [0 : 2])
                translate([
                    0,
                    fit_index
                    * (saddle_fit_coupon_length
                       + saddle_fit_coupon_spacing),
                    0
                ])
                    tile_fit_coupon(
                        fit_offsets[fit_index],
                        fit_index + 1
                    );
}
