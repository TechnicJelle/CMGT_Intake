Player player;
PVector ctrlInput;

int DASH_COOLDOWN = 1000; //in millis
int SWING_SPEED = 300; //in millis

int LEVEL;
interface LEVELS {
  int
    CABIN   = 0, 
    SHORE   = 1, 
    JUNGLE1 = 2, 
    JUNGLE2 = 3;
}

interface ENTITY_TYPE {
  int
    TEMP     = -1, 
    WALL     = 0, 
    OBSTACLE = 1, 
    PLAYER   = 2, 
    ENEMY    = 3, 
    SWORD    = 4, 
    TEMPWALL = 5;
}

PImage bkgr;
PImage PIMGshore;
PImage PIMGjungle1;
PImage PIMGjungle2;

ArrayList<Entity> obstacles = new ArrayList<Entity>();

void settings() {
  fullScreen();
}

PVector aim;
void mousePressed() {
  if (!player.swinging)
    setAim();
  btnSwing = true;
}
void mouseReleased() {
  //int x = int(mouseX - down.x);
  //int y = int(mouseY - down.y);
  //println("walls.add(new Entity(" + int(down.x) + ", " + int(down.y) + ", " + x + ", " + y + "));");
  btnSwing = false;
}

void setAim() {
  aim = new PVector(mouseX, mouseY).sub(PVector.add(player.pos, PVector.div(player.size, 2)));
  println(aim);
}


void setup() {
  player = new Player(width/2, height/2);

  LEVEL = LEVELS.CABIN;

  if (LEVEL == LEVELS.CABIN)
    thread("loadBackgrounds");
  else
    loadBackgrounds();
}

void loadBackgrounds() {
  PIMGshore = loadImage("Shore2.png");
  PIMGjungle1 = loadImage("Jungle1.png");
  PIMGjungle2 = loadImage("Jungle2.png");
}

void nextLevel() {
  LEVEL++;
  newLevelSetup = true;
  obstacles.clear();
}

void setLevel(int nl) {
  LEVEL = nl;
  newLevelSetup = true;
  obstacles.clear();
}

boolean newLevelSetup = true;

void draw() {
  switch(LEVEL) {
  case LEVELS.CABIN: //Cabin
    //Setup
    if (newLevelSetup) {
      LevelCabinSetup();
      newLevelSetup = false;
    }

    //Draw
    LevelCabinDraw();

    //Next Level
    if (!player.onScreen)
      nextLevel();
    break;
  case LEVELS.SHORE: //Shore
    //Setup
    if (newLevelSetup) {
      LevelShoreSetup();
      newLevelSetup = false;
    }

    //Draw
    LevelShoreDraw();

    //NextLevel
    if (!player.onScreen)
      nextLevel();
    break;
  case LEVELS.JUNGLE1: //Jungle1
    //Setup
    if (newLevelSetup) {
      LevelJungle1Setup();
      newLevelSetup = false;
    }

    //Draw
    LevelJungle1Draw();

    //NextLevel
    if (!player.onScreen)
      nextLevel();
    break;
  case LEVELS.JUNGLE2: //Shore
    //Setup
    if (newLevelSetup) {
      LevelJungle2Setup();
      newLevelSetup = false;
    }

    //Draw
    LevelJungle2Draw();

    //NextLevel
    if (!player.onScreen)
      nextLevel();
    break;
  }

  //textSize(16);
  //fill(255);
  //textAlign(LEFT, TOP);
  //text(LEVEL, 10, 10);


  // Gizmos
  //drawGrid();
}

boolean btnCtrlTop = false;
boolean btnCtrlBottom = false;
boolean btnCtrlLeft = false;
boolean btnCtrlRight = false;
boolean btnDash = false;
boolean btnSwing = false;

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
      break;
    case 'l':
      btnSwing = true;
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
    case 'l':
      btnSwing = false;
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

boolean aabb(Entity e1, Entity e2) {
  return aabb(e1.pos.x, e1.pos.y, e1.size.x, e1.size.y, e2.pos.x, e2.pos.y, e2.size.x, e2.size.y);
}

boolean aabb(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2)
{
  //adapted from: https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
  return x1 < x2 + w2  &&  x1 + w1 > x2 
    &&   y1 < y2 + h2  &&  y1 + h1 > y2;
}
