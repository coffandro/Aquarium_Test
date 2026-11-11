abstract class Fish {
  String name;
  PVector pos;
  PVector speed;
  int size;
  color col;
  FishTypes type;

  Fish(String _name, PVector _pos, FishTypes _type) {
    name = _name;
    pos = _pos;
    type = _type;
  }

  void update(Fish[] fishes) {
    pos.add(speed);
    
    limit_pos(fishes);
  }
  
  void limit_pos(Fish[] fishes) {
    if (pos.x < margin + size/2) {
      pos.x = margin + size/2;
      speed.x *= -1;
    } else if (pos.x > width - margin - size/2) {
      pos.x = width - margin - size/2;
      speed.x *= -1;
    }
    
    if (pos.y < margin + size/2) {
      pos.y = margin + size/2;
      speed.y *= -1;
    } else if (pos.y > height - margin - size/2) {
      pos.y = height - margin - size/2;
      speed.y *= -1;
    }
    
    // Collision with other fish
    for (int i = 0; i < fishes.length; i++) {
      Fish other = fishes[i];
      if (other == this) continue;
      if (other == null) continue;
      if (this.type == null || other.type == null) continue;
      if (this.type != other.type) continue;
    
      float minDist = (this.size + other.size) * 0.5;
      float d = PVector.dist(this.pos, other.pos);
    
      if (d > 0 && d < minDist) {
        // Collision normal
        PVector normal = PVector.sub(this.pos, other.pos);
        normal.normalize();
    
        // Push apart (resolve overlap)
        float overlap = minDist - d;
        this.pos.add(PVector.mult(normal, overlap * 0.5));
        other.pos.sub(PVector.mult(normal, overlap * 0.5));
    
        // Simple velocity reflection
        float bounce = 0.8;
        PVector relVel = PVector.sub(this.speed, other.speed);
        float sepVel = relVel.dot(normal);
    
        if (sepVel < 0) {
          PVector impulse = PVector.mult(normal, -sepVel * bounce);
          this.speed.add(impulse);
          other.speed.sub(impulse);
        }
      }
    }
  }

  void display() {
    fill(col);
    ellipse(pos.x, pos.y, size, size);
  }

  void eat() {
    aquarium.RemoveFish(this);
  }
}
