// M10 Bolt
union() {
  // A standard M10 bolt has a 19,62mm diameter and an height of 5mm
  color([0.5,0.5,0.5])
    cylinder(d=19.62, h=5, $fn=6);
  translate ([0,0,5])
    color([0.7,0.7,0.7])
      cylinder(d=10, h=50);
}
