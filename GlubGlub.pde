class GlubGlub extends Fish {
  float sharkAvoidDist = 80;
  float planktonSeekDist = 120;
  
  GlubGlub(String _name, PVector _pos, FishTypes _type) {
    super(_name, _pos, _type);

    // The main difference between our sub types
    float t_speed = random(0, 1);
    if (t_speed < 0.5) {
      t_speed = -1;
    } else {
      t_speed = 1;
    }

    col = color(100, 255, 255);
    speed = new PVector(t_speed, t_speed).normalize();
    size = 10;
  }
  
  void update(Fish[] fishes) {
    PVector avoidForce = new PVector();
    PVector seekForce = new PVector();

    for(int i = 0; i < fishes.length; i++) {
      if (fishes[i] == this) continue;
      
      Fish fish = fishes[i];
      
      float d = PVector.dist(this.pos, fish.pos);
      
      if (fish instanceof Shark && d < sharkAvoidDist) {
        PVector flee = PVector.sub(this.pos, fish.pos);
        flee.normalize();
        flee.mult((sharkAvoidDist - d) / sharkAvoidDist); // stronger when closer
        avoidForce.add(flee);
        
      } else if (fish instanceof Plankton) {
        if (d < size/2) {
          fish.eat();
        } else if (d < planktonSeekDist) {
          PVector seek = PVector.sub(fish.pos, this.pos);
          seek.normalize();
          seek.mult((planktonSeekDist - d) / planktonSeekDist);
          seekForce.add(seek);
        }
      }
    }
    
    // Weight behaviors
    avoidForce.mult(2.5);   // sharks are scary
    seekForce.mult(1.0);
    
    // Apply forces
    if (avoidForce.mag() != 0 || seekForce.mag() != 0) {
      speed = PVector.add(avoidForce, seekForce);
      speed.normalize();
    }

    pos.add(speed);
    
    limit_pos(fishes);
  }
}
