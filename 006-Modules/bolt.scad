// Standard Bolt
module bolt(d, h) {
  cylinder(d=1.9 * d, h=d/2, $fn=6);
  translate ([0,0,d/2])
    cylinder(d=d, h=h);
}
