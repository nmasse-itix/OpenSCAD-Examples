// A standard washer that has a nominal diameter of 12mm
difference() {
  cylinder(d=24, h=3, center=true);
  cylinder(d=12, h=4, center=true);
}
