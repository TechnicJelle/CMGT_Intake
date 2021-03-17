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
  //player.changeSize(200);
  resetPlayer(124, 100);

  player.speed = 1;

  bkgr = loadImage("Cabin2.png");

  obstacles.add(new Entity(0, 0, 1919, 50, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(607, 20, 705, 282, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(833, 322, 255, 186, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(845, 503, 231, 73, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(31, 720, 376, 338, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 0, 58, 755, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(387, 1026, 401, 53, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1134, 1026, 500, 53, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1568, 0, 351, 645, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1598, 664, 321, 415, ENTITY_TYPE.WALL));
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

  obstacles.add(new Entity(0, 0, 817, 551, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1104, 0, 805, 459, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(770, 0, 348, 40, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 0, 1, 1079, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1919, 0, 1, 1079, ENTITY_TYPE.WALL));

  obstacles.add(new EntitySprite(100, 800, "Crate.png", ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(1400, 700, "Crate.png", 300, ENTITY_TYPE.OBSTACLE));
}

void LevelShoreDraw() {
  background(bkgr);

  for (Entity o : obstacles) {
    if (o.TYPE != ENTITY_TYPE.WALL)
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

  obstacles.add(new Entity(0, -player.size.y-5, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 0, 1, 1079, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 1079, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1919, 0, 1, 1079, ENTITY_TYPE.TEMPWALL));

  obstacles.add(new EntitySprite(0, 581, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(0, 831, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(250, 831, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(912, 318, "SwordFull.png", ENTITY_TYPE.SWORD));
}

void LevelJungle1Draw() {
  background(bkgr);

  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Entity o = obstacles.get(i);
    if (o.TYPE != ENTITY_TYPE.WALL && o.TYPE != ENTITY_TYPE.TEMPWALL)
      o.render();
    if (player.hasSword && o.TYPE == ENTITY_TYPE.TEMPWALL)
      obstacles.remove(i);
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

  obstacles.add(new Entity(0, 0, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(-player.size.x-5, 0, 1, 1079, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 1079, 1919, 1, ENTITY_TYPE.WALL));
}

void LevelJungle2Draw() {
  background(bkgr);

  for (Entity o : obstacles) {
    if (o.TYPE != ENTITY_TYPE.WALL)
      o.render();
  }

  player.update();
  player.render();
}
