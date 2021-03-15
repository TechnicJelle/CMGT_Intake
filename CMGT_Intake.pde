Player player;
PVector ctrlInput;

String LEVEL;

PImage bkgr;

ArrayList<Entity> walls = new ArrayList<Entity>();

void settings() {
  fullScreen();
}

PVector down;
void mousePressed() {
  down = new PVector(mouseX, mouseY);
  //println("down:" + mouseX + "," + mouseY);
}
void mouseReleased() {
  //println("up:" + mouseX + "," + mouseY);
  int x = int(mouseX - down.x);
  int y = int(mouseY - down.y);
  //println("diff:" + x + "," + y);
  println("walls.add(new Entity(" + int(down.x) + ", " + int(down.y) + ", " + x + ", " + y + "));");
}


void setup() {
  player = new Player(width/2, height/2);

  LEVEL = "cabin";
}

void nextLevel(String nl) {
  LEVEL = nl;
  newLevelSetup = true;
}

boolean newLevelSetup = true;

void draw() {
  switch(LEVEL) {
  case "cabin": //Cabin
    //Setup
    if (newLevelSetup) {
      LevelCabinSetup();
      newLevelSetup = false;
    }

    //Draw
    LevelCabinDraw();

    //Next Level
    if (!player.onScreen)
      nextLevel("Shore");
    break;
  case "Shore": //Shore
    //Setup
    if (newLevelSetup) {
      LevelShoreSetup();
      newLevelSetup = false;
    }

    //Draw
    LevelShoreDraw();

    //NextLevel
    if (!player.onScreen)
      nextLevel("jungle");
    break;
  case "jungle": //Jungle
    if (newLevelSetup) {
      LevelJungleSetup();
      newLevelSetup = false;
    }
    LevelJungleDraw();
    break;
  }

  textSize(16);
  fill(255);
  textAlign(LEFT, TOP);
  text(LEVEL, 10, 10);


  // Gizmos
  //drawGrid();
}

boolean btnCtrlTop = false;
boolean btnCtrlBottom = false;
boolean btnCtrlLeft = false;
boolean btnCtrlRight = false;
boolean canDash = true;
boolean btnDash = false;
int millisAtDash = -1;

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    }
  } else {
    switch(key) {
    case 'w':
      btnCtrlTop = true;
      break;
    case 's':
      btnCtrlBottom = true;
      break;
    case 'a':
      btnCtrlLeft = true;
      break;
    case 'd':
      btnCtrlRight = true;
      break;
    case ' ':
      btnDash = true;
      millisAtDash = millis();
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    }
  } else {
    switch(key) {
    case 'w':
      btnCtrlTop = false;
      break;
    case 's':
      btnCtrlBottom = false;
      break;
    case 'a':
      btnCtrlLeft = false;
      break;
    case 'd':
      btnCtrlRight = false;
      break;
    case ' ':
      btnDash = false;
      break;
    }
  }
}

void drawInput(PVector i) {
  float x = width/2;
  float y = height/2;
  noFill();
  stroke(255);
  strokeWeight(2);
  ellipseMode(RADIUS);
  circle(x, y, 64);
  line(x, y, x + i.x*64, y + i.y*64);
}

void drawGrid() {
  final int TILE_SIZE = 64;
  stroke(255, 100);
  strokeWeight(1);
  for (int i = -TILE_SIZE; i < width+TILE_SIZE; i += TILE_SIZE) {
    line(i-1, 0, i-1, height);
  }
  for (int j = -TILE_SIZE; j < height+TILE_SIZE; j += TILE_SIZE) {
    line(0, j-1, width, j-1);
  }
}

boolean isAabbCollision(Entity e1, Entity e2) {
  return isAabbCollision(e1.pos.x, e1.pos.y, e1.size.x, e1.size.y, e2.pos.x, e2.pos.y, e2.size.x, e2.size.y);
}

boolean isAabbCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2)
{
  // Adapted from https://tutorialedge.net/gamedev/aabb-collision-detection-tutorial/
  return x1 < x2 + w2 &&
    x1 + w1 > x2 &&
    y1 < y2 + h2 &&
    y1 + h1 > y2;
}
