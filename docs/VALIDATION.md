# Batch 001 static validation

The archive was checked before packaging for:

- balanced OpenSCAD parentheses, brackets, and braces;
- valid local include paths;
- no source file above 500 lines;
- 10 mm pitch × 0.02 slope = 0.20 mm per register;
- 20 register movements = 200 mm travel and 4.00 mm elevation range;
- moving-wedge length equal to working travel plus full fixed-wedge overlap;
- positive moving-wedge thickness across its full 360 mm length;
- lock cassette phase aligned with the 10 mm rack period at every integer step;
- released pawl position below the fixed-wedge register-channel floor.

An OpenSCAD command-line renderer was not available in the packaging environment. The first user test must therefore include F5 preview and F6 render of each `part` selection before STL export.
