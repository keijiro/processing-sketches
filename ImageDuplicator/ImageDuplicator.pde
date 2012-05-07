String loadPath = selectInput("Select a png file.");
if (loadPath == null) exit();

String savePath = selectOutput("Save processed files.");
if (savePath == null) exit();

for (int i = 1; i <= 64; i++) {
  PImage img;
  img = loadImage(loadPath);
  img.resize(img.width * i / 64, img.height * i / 64);
  img.save(savePath + "." + i + ".png");
}

exit();

