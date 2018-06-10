include <MCAD/units.scad>;

$fn = 36;

// Size of the enclosure
useful_size = [ 15 * cm, 17 * cm, 9 * cm ];

// Thickness of the walls
wall_size = 3 * mm;

// Edges are soften with this radius
round_radius = 3 * mm;

// Vent Parameters (hexagon structure)
vent_alveolus_size = 6.5 * mm;
vent_margin = 1 * mm;
vent_xstep = cos(30) * (vent_margin + sqrt(3) * vent_alveolus_size / 2);
vent_ystep = sin(30) * (vent_margin + sqrt(3) * vent_alveolus_size / 2);

// Screw hole diameter for the four screws holding the cover
cover_screw_hole_diameter = 2.5 * mm;

module box(useful_size, wall_size) {
  difference() {
    translate([ -wall_size, -wall_size, -wall_size ])
      cube([ useful_size.x + 2 * wall_size, useful_size.y + 2 * wall_size, useful_size.z + wall_size ]);
    translate([ 0, 0, epsilon])
      cube([ useful_size.x, useful_size.y, useful_size.z ]);
  }
}

module rounded_corner(round_radius, length) {
  difference() {
    cube([ round_radius, round_radius, length ]);
    translate([ round_radius, round_radius, -epsilon ])
      cylinder(r=round_radius, h=length + 2 * epsilon);
  }
}

module at_four_corners(box) {
  translate([ box[0].x, box[0].y, 0 ])
      children();
  translate([ box[1].x, box[0].y, 0 ])
    rotate([ 0, 0, 90 ])
      children();
  translate([ box[1].x, box[1].y, 0 ])
    rotate([ 0, 0, 180 ])
      children();
  translate([ box[0].x, box[1].y, 0 ])
    rotate([ 0, 0, 270 ])
      children();
}

module rounded_box(useful_size, wall_size, round_radius, cover_screw_hole_diameter = 0) {
  difference() {
    union() {
      box(useful_size, wall_size);
      if (cover_screw_hole_diameter == 0) {
        at_four_corners([ [ 0, 0 ], useful_size ])
          rounded_corner(round_radius, useful_size.z);
      } else {
        at_four_corners([ [ 0, 0 ], useful_size ]) {
          reinforcement_size = wall_size + cover_screw_hole_diameter;
          difference() {
            cube([ reinforcement_size, reinforcement_size, useful_size.z ]);
            translate([ reinforcement_size + epsilon, reinforcement_size + epsilon, -epsilon ])
              rotate([ 0, 0, 180 ])
                rounded_corner(round_radius, useful_size.z + 2 * epsilon);
            translate([ cover_screw_hole_diameter / 2, cover_screw_hole_diameter / 2, epsilon ])
            cylinder(d = cover_screw_hole_diameter, h = useful_size.z + epsilon);
          }
          translate([ 0, reinforcement_size, 0 ])
            rounded_corner(round_radius, useful_size.z);
          translate([ reinforcement_size, 0, 0 ])
            rounded_corner(round_radius, useful_size.z);
        }
      }
    }
    at_four_corners([ [ -wall_size, -wall_size ], useful_size + [ wall_size, wall_size ] ])
      translate([ -epsilon, -epsilon, -wall_size - epsilon ])
        rounded_corner(round_radius, useful_size.z + wall_size + 2 * epsilon);
  }
}
