// Matrix Digital Rain Effect
// Creates the iconic falling code effect from The Matrix

ArrayList<Stream> streams;
PFont font;

void setup() {
  size(800, 600);
  
  // Create font
  font = createFont("Courier", 14);
  textFont(font);
  
  // Initialize streams
  streams = new ArrayList<Stream>();
  int cols = width / 15;
  
  for (int i = 0; i < cols; i++) {
    Stream stream = new Stream(i * 15, random(-1000, 0));
    streams.add(stream);
  }
  
  background(0);
}

void draw() {
  // Fade effect
  fill(0, 30);
  rect(0, 0, width, height);
  
  // Update and display streams
  for (Stream stream : streams) {
    stream.update();
    stream.display();
  }
}

class Stream {
  float x, y;
  float speed;
  ArrayList<Character> characters;
  int length;
  
  Stream(float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = random(3, 8);
    this.length = int(random(10, 30));
    
    characters = new ArrayList<Character>();
    generateCharacters();
  }
  
  void generateCharacters() {
    characters.clear();
    for (int i = 0; i < length; i++) {
      characters.add(new Character(getRandomChar(), x, y - i * 15));
    }
  }
  
  void update() {
    y += speed;
    
    // Update all characters
    for (int i = 0; i < characters.size(); i++) {
      Character c = characters.get(i);
      c.y = y - i * 15;
      
      // Randomly change characters
      if (random(1) < 0.01) {
        c.char_ = getRandomChar();
      }
    }
    
    // Reset when off screen
    if (y - length * 15 > height) {
      y = random(-500, -100);
      generateCharacters();
    }
  }
  
  void display() {
    for (int i = 0; i < characters.size(); i++) {
      Character c = characters.get(i);
      
      // Brightest at the front
      if (i == 0) {
        fill(140, 255, 140);
      } else {
        float brightness = map(i, 0, characters.size(), 255, 0);
        fill(0, brightness, 0);
      }
      
      text(c.char_, c.x, c.y);
    }
  }
  
  char getRandomChar() {
    // Mix of katakana and numbers
    if (random(1) < 0.5) {
      return char(int(random(0x30A0, 0x30FF))); // Katakana
    } else {
      return char(int(random(48, 58))); // Numbers 0-9
    }
  }
}

class Character {
  char char_;
  float x, y;
  
  Character(char c, float x, float y) {
    this.char_ = c;
    this.x = x;
    this.y = y;
  }
}