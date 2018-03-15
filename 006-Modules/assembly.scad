use <bolt.scad>
use <washer.scad>

washer(d=12,h=3);
translate([0,0,-7.5])
  bolt(d=12,h=50);
