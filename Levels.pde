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

  walls.add(new Entity(0, 0, 1919, 50));
  walls.add(new Entity(607, 20, 705, 282));
  walls.add(new Entity(833, 322, 255, 186));
  walls.add(new Entity(845, 503, 231, 73));
  walls.add(new Entity(31, 720, 376, 338));
  walls.add(new Entity(0, 0, 58, 755));
  walls.add(new Entity(387, 1026, 401, 53));
  walls.add(new Entity(1134, 1026, 500, 53));
  walls.add(new Entity(1568, 0, 351, 645));
  walls.add(new Entity(1598, 664, 321, 415));
}

void LevelCabinDraw() {
  background(bkgr);
  //background(100);

  player.update();
  player.render();

  //for (Entity w : walls) {
  //  w.render();
  //}
}


//Shore
void LevelShoreSetup() {
  player.changeSize(150);
  resetPlayer(width/2 - player.size.x/2, 100);
  player.vel = new PVector(0, 10);

  player.speed = 2;

  bkgr = PIMGshore;

  walls.add(new Entity(0, 0, 817, 551));
  walls.add(new Entity(1104, 0, 805, 459));
  walls.add(new Entity(770, 0, 348, 40));
  walls.add(new Entity(0, 0, 1, 1079));
  walls.add(new Entity(1919, 0, 1, 1079));
}

void LevelShoreDraw() {
  background(bkgr);
  //background(100);
  //for (Entity w : walls) {
  //  w.render();
  //}

  player.update();
  player.render();
}


//Jungle1
void LevelJungle1Setup() {
  player.changeSize(150);
  resetPlayer(width/2 - player.size.x/2, -player.size.y);
  player.vel = new PVector(0, 20);

  bkgr = PIMGjungle1;

  walls.add(new Entity(0, -player.size.y-5, 1919, 1));
  walls.add(new Entity(0, 0, 1, 1079));
  walls.add(new Entity(0, 1079, 1919, 1));
}

void LevelJungle1Draw() {
  background(bkgr);

  player.update();
  player.render();
}

//Jungle2
void LevelJungle2Setup() {
  player.changeSize(150);
  resetPlayer(-player.size.x/2, height/2 - player.size.y/2);
  player.vel = new PVector(20, 0);

  bkgr = PIMGjungle2;

  walls.add(new Entity(0, 0, 1919, 1));
  walls.add(new Entity(-player.size.x-5, 0, 1, 1079));
  walls.add(new Entity(0, 1079, 1919, 1));
}

void LevelJungle2Draw() {
  background(bkgr);

  player.update();
  player.render();
}
