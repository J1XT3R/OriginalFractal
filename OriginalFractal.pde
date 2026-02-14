int depth = 8;
float shrink = 0.52f;
float branchRot = 0.35f;
boolean animate = true;

void setup() {
  size(900, 700);
  smooth();
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(220, 10, 12);

  float t = animate ? frameCount * 0.01f : 0;
  float rot = branchRot + 0.25f * sin(t);

  translate(width/2, height/2);

  rotate(0.15f * sin(t * 0.7f));

  float startSize = min(width, height) * 0.35f;

  cornerBloom(0, 0, startSize, depth, rot, 200);
}

void cornerBloom(float x, float y, float sz, int d, float rot, float hue) {
  if (d <= 0 || sz < 2) return;

  stroke(hue % 360, 70, 95, 85);
  strokeWeight(max(1, sz * 0.02f));
  noFill();

  pushMatrix();
  translate(x, y);
  rotate(rot * (depth - d + 1));
  rect(0, 0, sz, sz);
  popMatrix();

  float half = sz * 0.5f;
  float child = sz * shrink;

  cornerBloom(x - half, y - half, child, d - 1, rot, hue + 18);
  cornerBloom(x + half, y - half, child, d - 1, rot, hue + 18);
  cornerBloom(x - half, y + half, child, d - 1, rot, hue + 18);
  cornerBloom(x + half, y + half, child, d - 1, rot, hue + 18);
}

void keyPressed() {
  if (keyCode == UP) depth = min(depth + 1, 14);
  if (keyCode == DOWN) depth = max(depth - 1, 0);

  if (keyCode == LEFT) branchRot -= 0.05f;
  if (keyCode == RIGHT) branchRot += 0.05f;

  if (key == 'w' || key == 'W') shrink = min(shrink + 0.02f, 0.70f);
  if (key == 's' || key == 'S') shrink = max(shrink - 0.02f, 0.35f);

  if (key == ' ') animate = !animate;

  if (key == 'r' || key == 'R') {
    depth = 8;
    shrink = 0.52f;
    branchRot = 0.35f;
    animate = true;
  }
}