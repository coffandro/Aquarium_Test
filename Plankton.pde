class Plankton extends Fish {
  Plankton(String _name, PVector _pos, FishTypes _type) {
    super(_name, _pos, _type);

    // The main difference between our sub types
    float t_speed = random(0, 1);
    if (t_speed < 0.5) {
      t_speed = -1;
    } else {
      t_speed = 1;
    }

    col = color(0, 255, 0);
    speed = new PVector(0, t_speed).normalize();
    size = 5;
  }
}
