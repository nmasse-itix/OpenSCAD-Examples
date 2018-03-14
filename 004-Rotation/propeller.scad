// Hub
cylinder(d=20, h=5, center=true);

// First blade
rotate([0, 15, 0])
  translate([-5,5,-1])
    cube([10, 30, 2]);

// Second blade
rotate([0, 15, 120])
  translate([-5,5,-1])
    cube([10, 30, 2]);

// Third blade
rotate([0, 15, 240])
  translate([-5,5,-1])
    cube([10, 30, 2]);
