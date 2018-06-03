include <MCAD/units.scad>;
include <common.scad>
use <OpenSCAD-Pattern-Filling/pattern.scad>;

module one_unit(unit_height) {
  translate([ 0, unit_height ]) {
    unit_voltmeter_size = [ 23 * mm, 10.5 * mm, wall_size + 2 * epsilon ];
    unit_voltmeter_spacing = 15 * mm;
    translate([ 0, unit_voltmeter_spacing ])
      cube(unit_voltmeter_size);

    unit_hole_diameter = 8 * mm;
    unit_hole_spacing = 10 * mm;
    translate([ unit_voltmeter_size.x / 2 - unit_hole_spacing / 2 - unit_hole_diameter / 2, 0 ])
      cylinder(d = unit_hole_diameter, h = wall_size + 2 * epsilon);
    translate([ unit_voltmeter_size.x / 2 + unit_hole_spacing / 2 + unit_hole_diameter / 2, 0 ])
      cylinder(d = unit_hole_diameter, h = wall_size + 2 * epsilon);
  }
}

module three_units(unit_height) {
  rotate([ 90, 0, 0 ]) {
    translate([ 30 * mm, 0, -epsilon ])
      one_unit(unit_height);
    translate([ 65 * mm, 0, -epsilon ])
      one_unit(unit_height);
    translate([ 100 * mm, 0, -epsilon ])
      one_unit(unit_height);
  }
}

module main_socket(socket_position) {
  // Main socket
  socket_dimension = [ wall_size + 2 * epsilon, 31 * mm, 22 * mm ];
  socket_mounting_holes_diameter = 2.5 * mm;
  socket_mounting_holes_position = [ 0, - 4.5 * mm, socket_dimension.z / 2 ];
  translate([ -wall_size - epsilon + socket_position.x, useful_size.y + socket_position.y, socket_position.z ]) {
    cube(socket_dimension);
    translate(socket_mounting_holes_position)
      rotate([ 0, 90, 0 ])
        cylinder(d = socket_mounting_holes_diameter, h = wall_size + 2 * epsilon);
    translate([ socket_mounting_holes_position.x, socket_dimension.y - socket_mounting_holes_position.y, socket_mounting_holes_position.z ] )
      rotate([ 0, 90, 0 ])
        cylinder(d = socket_mounting_holes_diameter, h = wall_size + 2 * epsilon);
  }
}

module main_switch(switch_position) {
  // Main switch
  switch_dimension = [ wall_size + 2 * epsilon, 19 * mm, 13 * mm ];
  translate([ -wall_size - epsilon + switch_position.x, useful_size.y + switch_position.y, switch_position.z ]) {
    cube(switch_dimension);
  }
}

module fan_vent(fan_vent_position) {
  // Fan vent
  fan_vent_size = [ 76.5 * mm, 76.5 * mm, wall_size + 2 * epsilon ];
  fan_vent_diameter = 90 * mm;
  fan_vent_mounting_hole_position = [ 36 * mm, 36 * mm ];
  fan_vent_mounting_hole_diameter = 5.5 * mm;
  translate([ -wall_size - epsilon, useful_size.y - fan_vent_position.x - fan_vent_size.x / 2, fan_vent_position.y + fan_vent_size.y / 2 ])
  rotate([ 0, 90, 0 ]) {
    intersection() {
      translate(-[ fan_vent_size.x, fan_vent_size.y] / 2)
        cube(fan_vent_size);
      cylinder(d = fan_vent_diameter, h = wall_size + 2 * epsilon, $fn = 180);
      spray_pattern([ fan_vent_size / -2, fan_vent_size / 2 ], [ [ 2 * vent_xstep, 0 ], [ vent_xstep, vent_ystep ] ]) {
        cylinder(d = vent_alveolus_size, h = wall_size + 2 * epsilon, $fn = 6);
      }
    }

    at_four_corners([ -fan_vent_mounting_hole_position, fan_vent_mounting_hole_position ])
      cylinder(d = fan_vent_mounting_hole_diameter, h = wall_size + 2 * epsilon);
  }
}

module back_vent() {
  // Back vents
  back_vent_crop = [ [ 10 * mm, 10 * mm ],
                     [ 30 * mm, 10 * mm ] ];
  back_vent_additional_margin = 30 * mm;
  back_vent_size = [ useful_size.y - back_vent_crop[0].x - back_vent_crop[1].x, useful_size.z - back_vent_crop[0].y - back_vent_crop[1].y ];
  translate([ useful_size.x - epsilon, 0, 0 ])
  rotate([ 0, 0, 180 ])
  rotate([ 0, -90, 0 ])
  rotate([ 0, 0, -90 ])
  intersection() {
    spray_pattern([ back_vent_crop[1], back_vent_size + back_vent_crop[1] ], [ [ 2 * vent_xstep, 0 ], [ vent_xstep, vent_ystep ] ]) {
      cylinder(d = vent_alveolus_size, h = wall_size + 2 * epsilon, $fn = 6);
    }
    translate(back_vent_crop[1])
      cube([ back_vent_size.x, back_vent_size.y, wall_size + 2 * epsilon ]);
  }
}

module two_leds(position) {
  rotate([ 90, 0, 0 ]) {
    led_hole_diameter = 5 * mm;
    led_margin = 10 * mm;
    translate(position + [ 0, 0, -epsilon ])
      cylinder(d = led_hole_diameter, h = wall_size + 2 * epsilon);
    translate(position + [ 0, led_margin, -epsilon ])
      cylinder(d = led_hole_diameter, h = wall_size + 2 * epsilon);
  }
}

module main_switch(position) {
  rotate([ 90, 0, 0 ]) {
    main_switch_size = [ 12 * mm, 19.5 * mm, 0 ];
    translate(position - main_switch_size / 2 + [ 0, 0, -epsilon ])
      cube(main_switch_size + [ 0, 0, wall_size + 2 * epsilon ]);
  }
}

module backplate_mount(position) {
  backplate_mount_screw_hole_diameter = 2.5 * mm;
  backplate_mount_screw_hole_height = 8 * mm;

  at_four_corners([ position, position + [ 94.75 * mm, -135 * mm ] ]) {
    difference() {
      cylinder(d = backplate_mount_screw_hole_diameter + wall_size * 2, h = backplate_mount_screw_hole_height);
      translate([ 0, 0, epsilon ])
        cylinder(d = backplate_mount_screw_hole_diameter, h = backplate_mount_screw_hole_height + 2 * epsilon);
    }
  }
}

difference() {
  rounded_box(useful_size, wall_size, round_radius, cover_screw_hole_diameter);
  main_socket([ 0, -133 * mm, 20 * mm ]);
  main_switch([ 0, -127 * mm, 60 * mm ]);
  fan_vent([ 10 * mm, 5 * mm ]);
  back_vent();
  three_units(unit_height = 40 * mm);
  two_leds([ 15 * mm, 60 * mm, 0 ]);
  main_switch([ 15 * mm, 20 * mm, 0 ]);
}
backplate_mount([ 36 * mm, useful_size.y - 8 * mm, 0 ]);
