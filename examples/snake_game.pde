// Simple Snake Game
// A classic snake game with colorful graphics

ArrayList<PVector> snake;
PVector food;
PVector direction;
int gridSize = 20;
boolean gameOver = false;
int score = 0;
int highScore = 0;

void setup() {
  size(800, 600);
  resetGame();
  frameRate(10);
}

void resetGame() {
  snake = new ArrayList<PVector>();
  snake.add(new PVector(width/2, height/2));
  direction = new PVector(gridSize, 0);
  placeFood();
  gameOver = false;
  score = 0;
}

void draw() {
  background(20);
  
  if (!gameOver) {
    updateSnake();
    checkCollisions();
    checkFood();
  }
  
  drawGrid();
  drawSnake();
  drawFood();
  drawUI();
}

void updateSnake() {
  PVector head = snake.get(0).copy();
  head.add(direction);
  
  // Wrap around edges
  if (head.x < 0) head.x = width - gridSize;
  if (head.x >= width) head.x = 0;
  if (head.y < 0) head.y = height - gridSize;
  if (head.y >= height) head.y = 0;
  
  snake.add(0, head);
  
  // Remove tail if not eating
  if (!head.equals(food)) {
    snake.remove(snake.size() - 1);
  }
}

void checkCollisions() {
  PVector head = snake.get(0);
  
  // Check self collision
  for (int i = 1; i < snake.size(); i++) {
    if (head.equals(snake.get(i))) {
      gameOver = true;
      if (score > highScore) {
        highScore = score;
      }
    }
  }
}

void checkFood() {
  PVector head = snake.get(0);
  if (head.equals(food)) {
    score += 10;
    placeFood();
  }
}

void placeFood() {
  int x = int(random(width/gridSize)) * gridSize;
  int y = int(random(height/gridSize)) * gridSize;
  food = new PVector(x, y);
  
  // Make sure food doesn't spawn on snake
  for (PVector segment : snake) {
    if (food.equals(segment)) {
      placeFood();
      return;
    }
  }
}

void drawGrid() {
  stroke(40);
  for (int x = 0; x < width; x += gridSize) {
    line(x, 0, x, height);
  }
  for (int y = 0; y < height; y += gridSize) {
    line(0, y, width, y);
  }
}

void drawSnake() {
  for (int i = 0; i < snake.size(); i++) {
    PVector segment = snake.get(i);
    
    if (i == 0) {
      // Head
      fill(100, 255, 100);
    } else {
      // Body with gradient
      float g = map(i, 0, snake.size(), 255, 100);
      fill(100, g, 100);
    }
    
    noStroke();
    rect(segment.x + 2, segment.y + 2, gridSize - 4, gridSize - 4, 4);
  }
}

void drawFood() {
  fill(255, 100, 100);
  noStroke();
  circle(food.x + gridSize/2, food.y + gridSize/2, gridSize - 4);
}

void drawUI() {
  fill(255);
  textAlign(LEFT);
  text("Score: " + score, 10, 20);
  text("High Score: " + highScore, 10, 40);
  
  if (gameOver) {
    textAlign(CENTER);
    textSize(48);
    fill(255, 100, 100);
    text("GAME OVER", width/2, height/2);
    textSize(24);
    fill(255);
    text("Press SPACE to play again", width/2, height/2 + 40);
    textSize(12);
  }
}

void keyPressed() {
  if (gameOver && key == ' ') {
    resetGame();
    return;
  }
  
  if (keyCode == UP && direction.y == 0) {
    direction = new PVector(0, -gridSize);
  } else if (keyCode == DOWN && direction.y == 0) {
    direction = new PVector(0, gridSize);
  } else if (keyCode == LEFT && direction.x == 0) {
    direction = new PVector(-gridSize, 0);
  } else if (keyCode == RIGHT && direction.x == 0) {
    direction = new PVector(gridSize, 0);
  }
}