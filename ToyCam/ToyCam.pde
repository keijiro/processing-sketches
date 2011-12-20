final int SSF = 11;   // shrinker scale factor
final int LSF = 2;    // enlarger scale factor

String sourcePath = selectInput();

PImage source = loadImage(sourcePath);
PImage shrinked = createImage(source.width / SSF, source.height / SSF, RGB);

PImage vignette = loadImage("Vignette.png");
source.blend(vignette,
             0, 0, vignette.width, vignette.height,
             0, 0, source.width, source.height, MULTIPLY);

final float PADJ = 1.33 / (SSF * SSF);

for (int y = 0; y < shrinked.height; y++) {
  for (int x = 0; x < shrinked.width; x++) {
    float r = 0, g = 0, b = 0;
    for (int dy = 0; dy < SSF; dy++) {
      for (int dx = 0; dx < SSF; dx++) {
        color p = source.get(x * SSF + dx, y * SSF + dy);
        r += red(p);
        g += green(p);
        b += blue(p);
      }
    }
    shrinked.set(x, y, color(PADJ * r, PADJ * g, PADJ * b));
  }
}

PImage processed = createImage(shrinked.width * LSF, shrinked.height * LSF, RGB);

for (int y = 0; y < processed.height; y++) {
  for (int x = 0; x < processed.width; x++) {
    color p = shrinked.get(x / LSF, y / LSF);
    if ((x % LSF) == 0 || (y % LSF) == 0) {
      p = blendColor(p, color(128), MULTIPLY);
    }
    processed.set(x, y, p);
  }
}

size(processed.width + 24, processed.height + 24);
background(0);
image(processed, 12, 12);
save(sourcePath + ".png");

