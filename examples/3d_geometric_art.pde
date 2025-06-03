// 3D Rotating Geometric Art
// Creates mesmerizing 3D shapes with dynamic colors

float rotation = 0;
float[][] vertices;
int shapeType = 0;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB, 360, 100, 100);
  generateShape();
}

void draw() {
  background(0);
  lights();
  
  // Center and rotate
  translate(width/2, height/2, 0);
  rotateX(rotation);
  rotateY(rotation * 0.7);
  rotateZ(rotation * 0.3);
  
  // Draw shape
  strokeWeight(2);
  noFill();
  
  beginShape(LINES);
  for (int i = 0; i < vertices.length; i++) {
    float hue = map(i, 0, vertices.length, 0, 360);
    stroke(hue, 80, 100);
    vertex(vertices[i][0], vertices[i][1], vertices[i][2]);
  }
  endShape();
  
  // Draw vertices as points
  strokeWeight(8);
  beginShape(POINTS);
  for (int i = 0; i < vertices.length; i++) {
    float hue = map(i, 0, vertices.length, 0, 360);
    stroke(hue, 100, 100);
    vertex(vertices[i][0], vertices[i][1], vertices[i][2]);
  }
  endShape();
  
  rotation += 0.01;
}

void generateShape() {
  int numPoints = 100;
  vertices = new float[numPoints][3];
  
  for (int i = 0; i < numPoints; i++) {
    float angle = map(i, 0, numPoints, 0, TWO_PI * 3);
    float radius = 150 + sin(angle * 2) * 50;
    float z = map(i, 0, numPoints, -200, 200);
    
    vertices[i][0] = cos(angle) * radius;
    vertices[i][1] = sin(angle) * radius;
    vertices[i][2] = z + sin(angle * 4) * 30;
  }
}

void mousePressed() {
  generateShape();
}