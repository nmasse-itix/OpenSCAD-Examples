module square_reinforcement(bounding_box, thickness, height, alveolus_size) {
  step = alveolus_size+thickness;
  xn = ceil((bounding_box[1][0] - bounding_box[0][0]) / step);
  yn = ceil((bounding_box[1][1] - bounding_box[0][1]) / step);
  origin = bounding_box[0];

  // Bounding box debug
  /*
  #polygon(points = [
    [bounding_box[0][0], bounding_box[0][1]],
    [bounding_box[1][0], bounding_box[0][1]],
    [bounding_box[1][0], bounding_box[1][1]],
    [bounding_box[0][0], bounding_box[1][1]]
  ]);
  */

  difference() {
    linear_extrude(height = height) {
      children();
    }
    for (y = [0:1:yn]) {
      for (x = [0:1:xn]) {
        posx = origin[0] + (x * step);
        posy = origin[1] + (y * step);
        translate([posx, posy, height / 2 + thickness])
          cube(size = [alveolus_size, alveolus_size, height - thickness], center = true);
      }
    }
  }

  linear_extrude(height = height) {
    difference() {
      children();
      offset(-thickness)
        children();
    }
  }
}
