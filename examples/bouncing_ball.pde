// Example Processing sketch: Bouncing Ball
// This demonstrates a simple animation that can be created using the MCP server

float x, y;
float xSpeed, ySpeed;
float ballSize = 50;

void setup() {
  size(800, 600);
  x = width/2;
  y = height/2;
  xSpeed = random(-5, 5);
  ySpeed = random(-5, 5);
}

void draw() {
  // Fade effect
  fill(0, 20);
  rect(0, 0, width, height);
  
  // Update position
  x += xSpeed;
  y += ySpeed;
  
  // Bounce off walls
  if (x > width - ballSize/2 || x < ballSize/2) {
    xSpeed *= -1;
  }
  if (y > height - ballSize/2 || y < ballSize/2) {
    ySpeed *= -1;
  }
  
  // Draw ball
  noStroke();
  fill(255, 100, 200);
  circle(x, y, ballSize);
}