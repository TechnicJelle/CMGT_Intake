void resetPlayer(float x, float y) {
  player.pos = new PVector(x, y);
  player.vel = new PVector(0, 0);
  player.acc = new PVector(0, 0);
  ctrlTop = false;
  ctrlBottom = false;
  ctrlLeft = false;
  ctrlRight = false;
}


//Cabin
void LevelCabinSetup() {
  resetPlayer(100, 100);
  player.speed = 1;
  bkgr = loadImage("/Environments/Cabin2.png");
}

void LevelCabinDraw() {
  background(bkgr);

  player.update();
  player.render();
}


//Shore
void LevelShoreSetup() {
  resetPlayer(width/2, 100);
  player.speed = 2;
  bkgr = loadImage("/Environments/Shore.png");
}

void LevelShoreDraw() {
  background(bkgr);

  player.update();
  player.render();
}


//Jungle
void LevelJungleSetup() {
  resetPlayer(100, height/2);
}

void LevelJungleDraw() {
  background(0, 255, 0);

  player.update();
  player.render();
}
