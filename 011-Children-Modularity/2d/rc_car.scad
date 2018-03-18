module rc_car(base, tip, junction) {
  polygon(points = [
    [base[0]/2, base[1]/2],
    [base[0]/2, -base[1]/2],
    [tip[0]/2, -base[1]/2-junction],
    [tip[0]/2, -base[1]/2-junction-tip[1]],
    [-tip[0]/2, -base[1]/2-junction-tip[1]],
    [-tip[0]/2, -base[1]/2-junction],
    [-base[0]/2, -base[1]/2],
    [-base[0]/2, base[1]/2],
    [-tip[0]/2, base[1]/2+junction],
    [-tip[0]/2, base[1]/2+junction+tip[1]],
    [tip[0]/2, base[1]/2+junction+tip[1]],
    [tip[0]/2, base[1]/2+junction]
  ]);
}
