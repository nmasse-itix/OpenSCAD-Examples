module washer(d, h) {
  difference() {
    cylinder(d=2*d, h=h, center=true);
    cylinder(d=d+1, h=h+1, center=true);
  }
}
