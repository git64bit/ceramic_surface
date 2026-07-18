/*
  Ceramic Surface - Batch 002 defaults
  Units: millimetres
*/

// ---------- OpenSCAD Customizer ----------
part = "saddle_assembly"; // [saddle_assembly,tpu_saddle,pla_datum_insert,saddle_fit_set,assembly,fixed_wedge,moving_wedge,lock_cassette,register_coupon]
position_steps = 8; // [0:1:20]
lock_state = "engaged"; // [engaged,released]
show_grout_cutaway = false;
exploded_view = false;
show_saddle_tile = true;

// ---------- Precision adjustment ----------
vertical_step = 0.20;
register_pitch = 10.00;
working_steps = 20;
working_travel = register_pitch * working_steps;
wedge_slope = vertical_step / register_pitch;
wedge_angle = atan(wedge_slope);

// ---------- Wedge envelope ----------
wedge_width = 100;
moving_length = 360;
fixed_length = 160;
fixed_base_height = 18;
moving_top_height = 26;

// The moving wedge begins 200 mm left of the fixed wedge at step 0.
moving_x_at_step_zero = -working_travel;

// ---------- Bearing and register layout ----------
bearing_rail_width = 24;
central_channel_y = bearing_rail_width;
central_channel_width = wedge_width - 2 * bearing_rail_width;
central_channel_depth = 5.20;

rack_width = 14;
rack_y_positions = [30, 56];
rack_margin = 15;
rack_depth = 3.60;
rack_crest_width = 2.20;
rack_holding_run = 0.70;
rack_root_chamfer = 0.60;

// ---------- Lock cassette ----------
lock_x = fixed_length / 2;
lock_body_length = 30;
lock_body_y = 26;
lock_body_width = 48;
lock_body_height = 5.50;
lock_body_top_clearance = 0.60;
lock_release_travel = 4.50;
lock_side_arm_length = 16;
lock_tab_projection = 10;
lock_tab_length = 24;
lock_tab_height = 5.50;
pawl_pairs = 2;
pawl_height = 3.00;
pawl_crest_width = 2.00;
pawl_holding_run = 0.80;
pawl_clearance = 0.35;

// ---------- Grout shell ----------
shell_wall = 5;
fixed_bottom_skin = 5;
fixed_top_skin = 7;
moving_bottom_skin = 6;
moving_top_skin = 6;
grout_fill_diameter = 14;
grout_vent_diameter = 4;
internal_rib_thickness = 4;

// ---------- Preview ----------
preview_tile_thickness = 9;
preview_tile_length = 584.2; // 23 inches
preview_tile_width = 279.4;  // 11 inches
saddle_preview_tile_depth = 78;
$fn = 48;

// ---------- TPU ceramic saddle ----------
saddle_fit_offset = 0.00; // [-0.50:0.05:0.50]
saddle_tile_gap_clearance = 0.30;
saddle_tile_gap = preview_tile_thickness
                + saddle_tile_gap_clearance
                + saddle_fit_offset;
saddle_length = 110;
saddle_depth = 52;
saddle_back_wall = 9.60;
saddle_jaw_thickness = 7.20;
saddle_corner_relief_diameter = 4.00;
saddle_drain_diameter = 5.00;

saddle_grip_rib_height = 0.65;
saddle_grip_rib_width = 5.60;
saddle_grip_rib_x_start = 7;
saddle_grip_rib_x_full = 18;
saddle_grip_rib_x_end = 49;
saddle_grip_rib_y_positions = [24, 55, 86];

// ---------- Rigid saddle datum insert ----------
saddle_datum_window_x = 10;
saddle_datum_window_width = 32;
saddle_datum_window_y = 0;
saddle_datum_window_length = 92;
saddle_datum_contact_proud = 0.15;

saddle_insert_center_x = saddle_datum_window_x
                       + saddle_datum_window_width / 2;
saddle_insert_y = 0;
saddle_insert_length = 96;
saddle_insert_slide_clearance = 0.35;
saddle_insert_deck_width = 28;
saddle_insert_deck_height = 8;
saddle_insert_flange_width = 38;
saddle_insert_flange_height = 3.20;
saddle_insert_pull_width = 22;
saddle_insert_pull_length = 10;
saddle_insert_pull_thickness = 4;
saddle_insert_attachment_hole = 6.50;

saddle_guide_wall = 5;
saddle_guide_drop = 6.30;
saddle_guide_lip_width = 4.35;
saddle_guide_lip_thickness = 2.40;
saddle_guide_stop_thickness = 7;
saddle_guide_detent_projection = 0.65;
saddle_guide_detent_length = 5;
saddle_guide_detent_height = 2.40;
saddle_guide_detent_y = 7;

// ---------- Saddle fit coupons ----------
saddle_fit_coupon_length = 28;
saddle_fit_coupon_depth = 32;
saddle_fit_coupon_spacing = 12;
saddle_fit_tight_offset = -0.25;
saddle_fit_nominal_offset = 0.00;
saddle_fit_relaxed_offset = 0.25;

// ---------- Manufacturing clearances ----------
general_clearance = 0.40;
sliding_clearance = 0.55;

// ---------- Derived values ----------
selected_step = min(max(position_steps, 0), working_steps);
selected_travel = selected_step * register_pitch;
moving_x = moving_x_at_step_zero + selected_travel;
moving_z = fixed_base_height + wedge_slope * moving_x;
minimum_stack_height = fixed_base_height + moving_top_height
                     + wedge_slope * moving_x_at_step_zero;
maximum_stack_height = minimum_stack_height
                     + working_steps * vertical_step;

assert(register_pitch > 0, "register_pitch must be positive");
assert(vertical_step > 0, "vertical_step must be positive");
assert(moving_length >= working_travel + fixed_length,
       "moving_length must cover full travel plus fixed-wedge overlap");
assert(central_channel_width > 2 * rack_width,
       "central channel is too narrow for both register racks");
assert(moving_top_height > wedge_slope * moving_length + moving_bottom_skin,
       "moving wedge becomes too thin at its narrow end");
assert(saddle_tile_gap > saddle_grip_rib_height,
       "saddle tile gap is too small for the grip rib");
assert(saddle_datum_window_x > saddle_guide_wall,
       "datum window leaves insufficient guide structure");
assert(saddle_insert_deck_width
       < saddle_insert_flange_width - 2 * saddle_insert_slide_clearance,
       "insert deck must pass between the TPU guide lips");
assert(saddle_insert_length + saddle_insert_y
       < saddle_length - saddle_guide_stop_thickness,
       "datum insert collides with the far guide stop");
