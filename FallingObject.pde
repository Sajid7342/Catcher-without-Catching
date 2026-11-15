
class FallingObject {
// Position, size and falling speed

  float x;
  float y;
  float size;
  float baseSpeed;

// Each object gets different colour
  color objectColor;
  
// Give each object random starting properties
  FallingObject() {

    x = random(30, width - 30);
    y = -30;

    size = random(20, 38);
    baseSpeed = random(2, 4);

    objectColor = color(
      random(100, 255),
      random(100, 255),
      random(100, 255)
    );
  }

  void update(int elapsedTime) {
// Make objects fall faster as the game progresses
    float currentSpeed = baseSpeed + elapsedTime * 0.03;

    y += currentSpeed;
  }

  void display() {

    noStroke();

    fill(objectColor);
    ellipse(x, y, size, size);

    // Highlight
    fill(255, 150);
    ellipse(x - 5, y - 5, size / 4, size / 4);
  }
}
