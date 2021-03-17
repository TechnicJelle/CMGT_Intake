void resetPlayer(float x, float y) {
  player.pos = new PVector(x, y);
  player.vel = new PVector(0, 0);
  player.acc = new PVector(0, 0);
  //btnCtrlTop = false;
  //btnCtrlBottom = false;
  //btnCtrlLeft = false;
  //btnCtrlRight = false;
}


//Cabin
void LevelCabinSetup() {
  player.changeSize(200);
  resetPlayer(124, 100);

  player.speed = 1;

  bkgr = loadImage("Cabin2.png");

  obstacles.add(new Entity(0, 0, 1919, 50));
  obstacles.add(new Entity(607, 20, 705, 282));
  obstacles.add(new Entity(833, 322, 255, 186));
  obstacles.add(new Entity(845, 503, 231, 73));
  obstacles.add(new Entity(31, 720, 376, 338));
  obstacles.add(new Entity(0, 0, 58, 755));
  obstacles.add(new Entity(387, 1026, 401, 53));
  obstacles.add(new Entity(1134, 1026, 500, 53));
  obstacles.add(new Entity(1568, 0, 351, 645));
  obstacles.add(new Entity(1598, 664, 321, 415));
}

void LevelCabinDraw() {
  background(bkgr);

  player.update();
  player.render();
}


//Shore
void LevelShoreSetup() {
  player.changeSize(150);
  resetPlayer(width/2 - player.size.x/2, 100);
  player.vel = new PVector(0, 10);

  player.speed = 2;

  bkgr = PIMGshore;

  obstacles.add(new Entity(0, 0, 817, 551));
  obstacles.add(new Entity(1104, 0, 805, 459));
  obstacles.add(new Entity(770, 0, 348, 40));
  obstacles.add(new Entity(0, 0, 1, 1079));
  obstacles.add(new Entity(1919, 0, 1, 1079));

  obstacles.add(new EntitySprite(100, 800, 200, 200, "Crate.png"));
  obstacles.add(new EntitySprite(1400, 700, 250, 250, "Crate.png"));
}

void LevelShoreDraw() {
  background(bkgr);

  for (Entity o : obstacles) {
    o.render();
  }

  player.update();
  player.render();

  textSize(32);
  fill(255);
  textAlign(LEFT, TOP);
  text("Press SPACE to dash!", 10, 10);
}


//Jungle1
void LevelJungle1Setup() {
  player.changeSize(150);
  resetPlayer(width/2 - player.size.x/2, -player.size.y);
  player.vel = new PVector(0, 20);

  bkgr = PIMGjungle1;

  obstacles.add(new Entity(0, -player.size.y-5, 1919, 1));
  obstacles.add(new Entity(0, 0, 1, 1079));
  obstacles.add(new Entity(0, 1079, 1919, 1));

  obstacles.add(new EntitySprite(1400, 700, 250, 250, "Barrel.png"));
}

void LevelJungle1Draw() {
  background(bkgr);

  for (Entity o : obstacles) {
    o.render();
  }
  
  player.update();
  player.render();
}

//Jungle2
void LevelJungle2Setup() {
  player.changeSize(150);
  resetPlayer(-player.size.x/2, height/2 - player.size.y/2);
  player.vel = new PVector(20, 0);

  bkgr = PIMGjungle2;

  obstacles.add(new Entity(0, 0, 1919, 1));
  obstacles.add(new Entity(-player.size.x-5, 0, 1, 1079));
  obstacles.add(new Entity(0, 1079, 1919, 1));
}

void LevelJungle2Draw() {
  background(bkgr);

  player.update();
  player.render();
}
