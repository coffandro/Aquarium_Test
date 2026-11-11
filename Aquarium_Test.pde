Aquarium aquarium;
int margin = 10;

String[] names = {
  "Elijah",
  "Olivia",
  "Noah",
  "Amelia",
  "Oliver",
  "Sophia",
  "Theodore",
  "Charlotte",
  "Liam",
  "Emma",
  "Henrik (He/Him)",
};

String random_name() {
  return names[int(random(0, names.length - 1))];
}

void setup() {
  //size(400, 400);
  size(1280, 720);
  noStroke();
  aquarium = new Aquarium();
}

float random_x() {
  return random(margin*2, width - margin*2);
}

float random_y() {
  return random(margin*2, height - margin*2);
}

// Mainloop
void draw() {
  // Update
  aquarium.update();

  background(0);
  // Draw
  aquarium.draw();
}
