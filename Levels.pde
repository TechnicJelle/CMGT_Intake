void resetPlayer(float x, float y) {
  player.pos = new PVector(x, y);
  player.vel = new PVector(0, 0);
  player.acc = new PVector(0, 0);
  //btnCtrlTop = false;
  //btnCtrlBottom = false;
  //btnCtrlLeft = false;
  //btnCtrlRight = false;
}

void tutorialText(String t) {
  canvas.textAlign(LEFT, TOP);
  canvas.textSize(32);
  canvas.fill(255);
  canvas.text(t, 10, 10);
}

void dialog(PImage chara, String text) {
  float padding = 8;
  canvas.stroke(0);
  canvas.strokeWeight(padding/3);
  canvas.textSize(31);
  canvas.pushMatrix();
  canvas.translate(0, canvas.height - chara.height);
  canvas.fill(106, 101, 82, 200);
  canvas.rect(padding, -padding *3, canvas.width - chara.width - padding *5, chara.height + padding *2, padding*4); //textbox
  canvas.fill(186, 179, 154, 200);
  canvas.rect(canvas.width - chara.width - padding *3, -padding *3, chara.width + padding *2, chara.height + padding *2, padding*4); //charabox
  canvas.image(chara, canvas.width - chara.width - padding *2, -padding *2);
  canvas.noStroke();
  canvas.fill(255, 10);
  canvas.rect(padding *5, padding, canvas.width - chara.width - padding *13, chara.height - padding *6, padding);
  canvas.fill(255);
  canvas.text(text, padding *5, padding, canvas.width - chara.width - padding *13, chara.height - padding *6);
  canvas.popMatrix();
}


//Cabin
void LevelCabinSetup() {
  //player.changeSize(200);
  resetPlayer(124, 100);

  player.speed = 2;

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
  canvas.background(bkgr);

  player.update();
  player.render();
  if (millis() - levelMillis < 10000)
    dialog(captain, "'Ello there, sport!\nWake up! We've arrived!\n\nYou've still gotta explain to me why you wanted to go here when you get back, al'ight?");
  else if (millis() - levelMillis < 20000)
    dialog(main, "I should go over my notes just once more before I go.");
  else if (dist(133, 794, player.pos.x, player.pos.y) < 300 /* && aabb(mouseX, mouseY, 1, 1, 133, 794, 248, 213)*/) {
    canvas.image(notesL, canvas.width/2 - notesL.width, 0);
    canvas.image(notesR, canvas.width/2, 0);
  }
  tutorialText("WASD to move");
}


//Shore
void LevelShoreSetup() {
  player.changeSize(150);
  resetPlayer(canvas.width/2 - player.size.x/2, 100);
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
  canvas.background(bkgr);

  for (Entity o : obstacles) {
    if (o.TYPE != ENTITY_TYPE.WALL)
      o.render();
  }

  player.update();
  player.render();

  tutorialText("Press SPACE to dash!");
}


//Jungle1
void LevelJungle1Setup() {
  player.changeSize(150);
  resetPlayer(canvas.width/2 - player.size.x/2, -player.size.y);
  player.vel = new PVector(0, 20);

  bkgr = PIMGjungle1;

  obstacles.add(new Entity(0, -player.size.y-5, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 0, 1, 1079, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 1079, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(1919, 0, 1, 1079, ENTITY_TYPE.TEMPWALL));

  obstacles.add(new EntitySprite(0, 581, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(0, 831, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(250, 831, "Barrel.png", 250, ENTITY_TYPE.OBSTACLE));
  obstacles.add(new EntitySprite(1200, 450, "SwordFull.png", ENTITY_TYPE.SWORD));
}

void LevelJungle1Draw() {
  canvas.background(bkgr);

  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Entity o = obstacles.get(i);
    if (o.TYPE != ENTITY_TYPE.WALL && o.TYPE != ENTITY_TYPE.TEMPWALL)
      o.render();
    if (player.hasSword && o.TYPE == ENTITY_TYPE.TEMPWALL)
      obstacles.remove(i);
  }

  player.update();
  player.render();
  if (!player.hasSword) {
    tutorialText("Pick up the sword");
  }
}

//Jungle2
void LevelJungle2Setup() {
  player.changeSize(150);
  resetPlayer(-player.size.x/2, canvas.height/2 - player.size.y/2);
  player.vel = new PVector(20, 0);

  bkgr = PIMGjungle2;

  obstacles.add(new Entity(0, 0, 1919, 1, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(-player.size.x-5, 0, 1, 1079, ENTITY_TYPE.WALL));
  obstacles.add(new Entity(0, 1079, 1919, 1, ENTITY_TYPE.WALL));
}

void LevelJungle2Draw() {
  canvas.background(bkgr);

  for (Entity o : obstacles) {
    if (o.TYPE != ENTITY_TYPE.WALL)
      o.render();
  }

  player.update();
  player.render();
  tutorialText("Left Click to swing your sword");
}

void LevelFinaleSetup() {
  player.changeSize(200);
  resetPlayer(canvas.width/2, canvas.height/2);
  player.vel = new PVector(0, 0);
}

void LevelFinaleDraw() {
  canvas.background(100);
  player.update();
  player.render();

  canvas.textAlign(CENTER, CENTER);
  canvas.textSize(64);
  canvas.fill(255);
  canvas.text("End of the demo!\nESC to close\nPress C to see the concept art", canvas.width/2, canvas.height/2);
}
