# Batch 002 static validation

The project was checked before packaging for:

- balanced OpenSCAD parentheses, brackets and braces;
- valid local include paths;
- no source file above 500 lines;
- all Batch 001 wedge invariants;
- 10 mm pitch × 0.02 slope = 0.20 mm per register;
- 20 register movements = 200 mm travel and 4.00 mm elevation range;
- positive moving-wedge thickness across its full length;
- saddle insert length clearing the closed TPU guide stop;
- rigid insert deck width clearing the two TPU guide lips;
- positive saddle gap after the grip-rib projection;
- nominal effective saddle grip gap of 8.50 mm;
- three fit coupon offsets of -0.25, 0.00 and +0.25 mm;
- printable orientation modules for the TPU saddle and fit set;
- PLA+ datum insert generated with its broad external deck on the XY plane.

OpenSCAD command-line rendering was not available in the packaging environment. The user test must include F5 preview and F6 render of:

1. `saddle_fit_set`;
2. `tpu_saddle`;
3. `pla_datum_insert`;
4. `saddle_assembly`;
5. the retained Batch 001 `assembly`.
