
ArrayList<FallingObject> objects = new ArrayList<FallingObject>();

Player player;

int lives = 3;
int score = 0;
// Keeps track of which screen the game is showing
// 0 = Start, 1 = Playing, 2 = Game over
int gameState = 0;
// 0 = Start screen
// 1 = Playing
// 2 = Game over

// Timer variables
int startTime;
int gameDuration = 60;
int lastSpawnTime;

//  check which direction the player is moving
boolean leftHeld = false;
boolean rightHeld = false;

void setup() {
  size(800, 600);

  player = new Player(width / 2, height - 70);
}

void draw() {
  background(25, 30, 55);

  if (gameState == 0) {
    drawStartScreen();
  } 
  else if (gameState == 1) {
    drawGame();
  } 
  else if (gameState == 2) {
    drawGameOver();
  }
}

void drawStartScreen() {
  fill(255);
  textAlign(CENTER);

  textSize(42);
  text("CATCHER WITHOUT CATCHING", width / 2, 180);

  textSize(22);
  text("Don't catch anything!", width / 2, 260);

  textSize(17);
  text("Use LEFT and RIGHT arrows or A and D.", width / 2, 320);
  text("Avoid falling objects for 60 seconds.", width / 2, 355);
  text("You have 3 lives.", width / 2, 390);

  fill(100, 255, 150);
  textSize(24);
  text("Press SPACE to start", width / 2, 470);
}

void drawGame() {


// Move the player depending on which key is pressed
  if (leftHeld) {
    player.moveLeft();
  }

  if (rightHeld) {
    player.moveRight();
  }
//  Update the player's position and draw them
  player.update();
  player.display();

// Work out how much time has passed
  int elapsedTime = (millis() - startTime) / 1000;
  int remainingTime = gameDuration - elapsedTime;

  int spawnInterval = max(300, 850 - elapsedTime * 8);

  if (millis() - lastSpawnTime > spawnInterval) {
    objects.add(new FallingObject());
    lastSpawnTime = millis();
  }

  for (int i = objects.size() - 1; i >= 0; i--) {

    FallingObject obj = objects.get(i);

    obj.update(elapsedTime);
    obj.display();
 // Check if the falling object touches the player
    float distance = dist(player.x, player.y, obj.x, obj.y);
    float collisionDistance = 18 + obj.size / 2;
// Check if the player has collided with an object
    if (distance < collisionDistance) {
      lives--;
      objects.remove(i);
  // End the game when no lives are left
      if (lives <= 0) {
        gameState = 2;
      }

      continue;
    }
    // Add to the score when an object passes the player
    if (obj.y > height + obj.size) {
      score++;
      objects.remove(i);
    }
  }
 // Display the current score, lives and remaining time
  fill(255);
  textAlign(LEFT);
  textSize(20);

  text("Score: " + score, 25, 35);
  text("Lives: " + lives, 25, 65);
  text("Time: " + max(0, remainingTime), 25, 95);

  stroke(100, 200, 255);
  line(0, height - 35, width, height - 35);
  noStroke();
  
  // Finish the game if the timer runs out and the player is still alive
  if (remainingTime <= 0 && lives > 0) {
    gameState = 2;
  }
}
// Display the final screen when the game ends
void drawGameOver() {

  background(25, 30, 55);
  textAlign(CENTER);
 // Show a different message depending on whether the player survived
  if (lives > 0) {
    fill(100, 255, 150);
    textSize(45);
    text("YOU SURVIVED!", width / 2, 200);
  } 
  else {
    fill(255, 80, 80);
    textSize(45);
    text("GAME OVER", width / 2, 200);
  }

  // Display the final score and restart instructions
  fill(255);
  textSize(25);
  text("Final Score: " + score, width / 2, 290);

  textSize(20);
  text("Press SPACE to play again", width / 2, 390);
}
// Reset the game variables before starting a new round

void startGame() {

  lives = 3;
  score = 0;

  // Create a new player in the starting position
  player = new Player(width / 2, height - 70);

  objects.clear();

  startTime = millis();
  lastSpawnTime = millis();
  // Make sure no movement keys remain pressed
  leftHeld = false;
  rightHeld = false;

  // Switch to the playing screen
  gameState = 1;
}

void keyPressed() {

  if (key == ' ' && (gameState == 0 || gameState == 2)) {
    startGame();
  }

  if (gameState == 1) {
 // Move right using the arrow key or D
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      leftHeld = true;
    }

    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      rightHeld = true;
    }
  }
}
// Checks when a key is released
void keyReleased() {
// Stop moving left when the key is released
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    leftHeld = false;
  }
 // Stop moving right when the key is released
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    rightHeld = false;
  }
}
