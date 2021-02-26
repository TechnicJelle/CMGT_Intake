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
}

void LevelCabinDraw() {
  background(100);

  player.update();
  player.render();
}


//Pier
void LevelPierSetup() {
  resetPlayer(width/2, 100);
  player.speed = 2;
}

void LevelPierDraw() {
  background(0, 0, 255);

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
