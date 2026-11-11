class Shark extends Fish {
  float pursueDist = 200;
  PVector last_pos;
  PVector tail_start_pos;
  PVector tail_end_pos;
  
  Shark(String _name, PVector _pos, FishTypes _type) {
    super(_name, _pos, _type);
    
    tail_start_pos = _pos.copy().sub(new PVector(0, -5));
    tail_end_pos = tail_start_pos.copy().sub(new PVector(0, -5));

    // The main difference between our sub types
    float t_speed = random(0, 1);
    if (t_speed < 0.5) {
      t_speed = -1;
    } else {
      t_speed = 1;
    }

    col = color(255, 0, 0);
    speed = new PVector(t_speed, 0).normalize();
    size = 15;
  }
  
  void update(Fish[] fishes) {
    last_pos = pos.copy();
    
    Fish target = null;
    float closestDist = pursueDist;

    // Find closest prey
    for (int i = 0; i < fishes.length; i++) {
      Fish fish = fishes[i];

      if (fish == this) continue;
      if (fish instanceof Shark) continue;
      if (fish instanceof Plankton) continue;

      float d = PVector.dist(this.pos, fish.pos);
      if (d < size/2) {
        fish.eat();
      } else if (d < closestDist) {
        closestDist = d;
        target = fish;
      }
    }

    // Pursue target
    if (target != null) {
      PVector desired = PVector.sub(target.pos, this.pos);
      desired.normalize();
      desired.mult(0.15); // steering strength
      speed.add(desired);
      speed.normalize();
    }

    pos.add(speed);
    
    limit_pos(fishes);
    
    tail_start_pos = PVector.lerp(tail_start_pos, pos, 0.075);
    tail_end_pos = PVector.lerp(tail_end_pos, tail_start_pos, 0.075);
  }
  
  void display() {
    fill(col);
    float main_rot = PVector.sub(tail_start_pos, pos).heading() + radians(90);
    
    // Body
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(main_rot);
      ellipse(0, 0, size, size * 1.5);
    popMatrix();
    
    float start_tail_rot = PVector.sub(tail_end_pos, tail_start_pos).heading() + radians(90);
    
    // Start tail
    pushMatrix();
      translate(tail_start_pos.x, tail_start_pos.y);
      rotate(start_tail_rot);
      ellipse(0, 0, size/1.5, size);
    popMatrix();
    
    float end_tail_rot = PVector.sub(tail_end_pos, tail_start_pos).heading() + radians(90);
    
    // End tail
    pushMatrix();
      translate(tail_end_pos.x, tail_end_pos.y);
      rotate(end_tail_rot);
      ellipse(0, 0, size/1.5, size);
      triangle(size/2.5, -size/6, -size/2.5, -size/6, 0, -size);
    popMatrix();
    
    // Body fins
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(start_tail_rot);
      triangle(0, 0, 0, size/1.5, size, -size/1.5);
      triangle(0, 0, 0, size/1.5, -size, -size/1.5);
      
      // Tail fins
      //fill(255);
      triangle(0, 0, 0, -size, -size/1.5, -size);
      triangle(0, 0, 0, -size, size/1.5, -size);
    popMatrix();
    
    // Name
    fill(255);
    text(name, pos.x + 10, pos.y);
  }
}
