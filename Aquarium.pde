enum FishTypes {
  PREDATOR,
    PLANKTON,
    NEUTRAL
};

class Aquarium {
  Fish[] fishes;

  Aquarium() {
    int name_i = 0;
    fishes = new Fish[1000];
    
    for (int i = 0; i < fishes.length; i++) {
      if (name_i < names.length) { // First ten or so, based on names
        AddFish(i, FishTypes.PREDATOR, name_i);
        name_i++;
      } else if (i % 20 == 0) { // Every tenth 
        AddFish(i, FishTypes.NEUTRAL);
      } else {
        AddFish(i, FishTypes.PLANKTON);
      }
    }
  }

  void update() {
    for (int i = 0; i < fishes.length; i++) {
      fishes[i].update(fishes);
    }
  }

  void draw() {
    fill(0, 0, 255);
    rect(margin, margin, width-margin*2, height-margin*2);

    for (int i = 0; i < fishes.length; i++) {
      fishes[i].display();
    }
  }

  void AddFish(int _i, FishTypes type, int _name_i) {
    if (type == FishTypes.PREDATOR) {
      fishes[_i] = new Shark(names[_name_i], new PVector(random_x(), random_y()), type);
    } else if (type == FishTypes.NEUTRAL) {
      fishes[_i] = new GlubGlub("", new PVector(random_x(), random_y()), type);
    } else if (type == FishTypes.PLANKTON) {
      fishes[_i] = new Plankton("", new PVector(random_x(), random_y()), type);
    }
  }
  
  void AddFish(int _i, FishTypes type) {
    AddFish(_i, type, _i);
  }

  void AddFish(FishTypes type) {
    int _i = fishes.length;

    Fish[] t_fishes = new Fish[fishes.length + 1];

    for (int i = 0; i < fishes.length; i++) {
      t_fishes[i] = fishes[i];
    }

    fishes = t_fishes;
    AddFish(_i, type);
  }
  
  void collapse_fishes() {
    ArrayList<Fish> ta_fishes = new ArrayList<Fish>();
    
    // Add into temp array list
    for(int i = 0; i < fishes.length; i++) {
      if (fishes[i] == null) continue;
      
      ta_fishes.add(fishes[i]);
    }
    
    Fish[] t_fishes = new Fish[ta_fishes.size()];
    for(int i = 0; i < ta_fishes.size(); i++) {
      t_fishes[i] = ta_fishes.get(i);
    }
    
    fishes = t_fishes;
  }
  
  void RemoveFish(Fish fish) {
    for(int i = 0; i < fishes.length; i++) {
      if (fishes[i] == fish) {
        fishes[i] = null;
      }
    }
    
    collapse_fishes();
  }
}
