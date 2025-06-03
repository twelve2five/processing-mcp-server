// Particle System with Mouse Interaction
// Creates a beautiful particle effect that follows your mouse

ArrayList<Particle> particles;
int maxParticles = 500;

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>();
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
}

void draw() {
  // Fade background
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);
  
  // Add new particles at mouse position
  if (particles.size() < maxParticles) {
    particles.add(new Particle(mouseX, mouseY));
  }
  
  // Update and display particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    
    if (p.isDead()) {
      particles.remove(i);
    }
  }
  
  // Display info
  fill(255);
  text("Particles: " + particles.size(), 10, 20);
}

class Particle {
  PVector position;
  PVector velocity;
  float lifespan;
  float hue;
  float size;
  
  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(random(1, 4));
    lifespan = 255;
    hue = random(180, 280); // Blue to purple range
    size = random(3, 8);
  }
  
  void update() {
    position.add(velocity);
    velocity.mult(0.98); // Friction
    lifespan -= 2;
    
    // Gravity effect
    velocity.y += 0.1;
  }
  
  void display() {
    noStroke();
    fill(hue, 80, 100, lifespan/255.0 * 100);
    circle(position.x, position.y, size);
  }
  
  boolean isDead() {
    return lifespan <= 0;
  }
}