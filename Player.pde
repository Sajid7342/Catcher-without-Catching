
class Player {
// Player position and movement speed
  float x;
  float y;
  float speed = 5;
// Set the player's starting position
  Player(float startX, float startY) {
    x = startX;
    y = startY;
  }

  void moveLeft() {
    x -= speed;
  }

  void moveRight() {
    x += speed;
  }
 // Stop the player from leaving the screen
  void update() {
    x = constrain(x, 25, width - 25);
  }

  void display() {

    noStroke();

    // Body
    fill(70, 170, 255);
    ellipse(x, y, 45, 45);

    // Eyes
    fill(255);
    ellipse(x - 8, y - 5, 9, 9);
    ellipse(x + 8, y - 5, 9, 9);

    fill(0);
    ellipse(x - 8, y - 5, 4, 4);
    ellipse(x + 8, y - 5, 4, 4);

    // Smile
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y + 3, 17, 12, 0, PI);

    noStroke();

    // Feet
    fill(70, 170, 255);
    ellipse(x - 12, y + 23, 12, 8);
    ellipse(x + 12, y + 23, 12, 8);
  }
}
