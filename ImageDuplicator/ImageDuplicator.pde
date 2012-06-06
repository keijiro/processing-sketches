int i = 0;

void setup() {
  size(1024, 1024);
}

void draw()
{
  background(255);
  fill(0);

  textSize(512);
  textAlign(CENTER, CENTER);

  if (frameCount < 600) {
    text(str(frameCount), 0, 0, width, height);
    saveFrame("tex####.png");
  }
}

