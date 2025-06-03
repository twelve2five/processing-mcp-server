// Generative Wave Art
// Creates beautiful animated wave patterns with rainbow colors

float phase = 0;
int waves = 5;
float amplitude = 50;
boolean isPaused = false;

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100);
  strokeWeight(2);
  noFill();
}

void draw() {
  // Dark background with trails
  fill(0, 20);
  rect(0, 0, width, height);
  
  if (!isPaused) {
    phase += 0.02;
  }
  
  // Draw multiple waves
  for (int w = 0; w < waves; w++) {
    beginShape();
    
    for (int x = 0; x < width; x += 2) {
      float y = height/2;
      
      // Stack multiple sine waves
      for (int i = 1; i <= 4; i++) {
        y += sin((x * 0.01 * i) + (phase * i) + (w * 0.5)) * 
             (amplitude / i);
      }
      
      // Color based on position and wave number
      float hue = (x * 0.5 + w * 60 + frameCount * 0.5) % 360;
      stroke(hue, 80, 100);
      
      vertex(x, y);
    }
    
    endShape();
  }
  
  // Instructions
  fill(255);
  text("Click to pause/resume | Move mouse to change amplitude", 10, 20);
  text("Amplitude: " + nf(amplitude, 0, 1), 10, 40);
}

void mouseMoved() {
  amplitude = map(mouseY, 0, height, 10, 150);
}

void mousePressed() {
  isPaused = !isPaused;
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    phase = 0;
  } else if (key == '+' || key == '=') {
    waves = min(waves + 1, 10);
  } else if (key == '-' || key == '_') {
    waves = max(waves - 1, 1);
  }
}