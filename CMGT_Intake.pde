PGraphics canvas;
boolean fullHD;

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
    JUNGLE2 = 3, 
    FINALE  = 4;
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
PImage notesL, notesR;
PImage captain, main;
PImage PIMGshore;
PImage PIMGjungle1;
PImage PIMGjungle2;

int levelMillis = -1;

ArrayList<Entity> obstacles = new ArrayList<Entity>();

void settings() {
  fullScreen();
  //size(1280, 720);
}

PVector aim;
//PVector down;
void mousePressed() {
  //down = new PVector(mouseX, mouseY);
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
  aim = screenScale(new PVector(mouseX, mouseY)).sub(PVector.add(player.pos, PVector.div(player.size, 2)));
}


void setup() {
  surface.setIcon(loadImage("Icon.png"));
  canvas = createGraphics(1920, 1080);
  fullHD = width == 1920 && height == 1080;
  player = new Player(canvas.width/2, canvas.height/2);

  setLevel(LEVELS.CABIN);

  if (LEVEL == LEVELS.CABIN)
    thread("loadData");
  else
    loadData();
}

void loadData() {
  captain = loadImage("Captain.png");
  main = loadImage("Main.png");
  notesL = loadImage("NotesL.png");
  notesR = loadImage("NotesR.png");
  PIMGshore = loadImage("Shore2.png");
  PIMGjungle1 = loadImage("Jungle1.png");
  PIMGjungle2 = loadImage("Jungle2.png");
}

void nextLevel() {
  setLevel(++LEVEL);
}

void setLevel(int nl) {
  LEVEL = nl;
  newLevelSetup = true;
  levelMillis = millis();
  obstacles.clear();
}

boolean newLevelSetup = true;

void draw() {
  canvas.beginDraw();
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
  case LEVELS.JUNGLE2: //Jungle2
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
  case LEVELS.FINALE: //Shore
    //Setup
    if (newLevelSetup) {
      LevelFinaleSetup();
      newLevelSetup = false;
    }

    //Draw
    LevelFinaleDraw();
    break;
  }

  //textSize(16);
  //fill(255);
  //textAlign(LEFT, TOP);
  //text(LEVEL, 10, 10);


  // Gizmos
  //drawGrid();
  canvas.endDraw();
  if (fullHD) {
    image(canvas, 0, 0);
  } else {
    PImage finalFrame = canvas.get();
    finalFrame.resize(width, height);
    image(finalFrame, 0, 0);
  }
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
    case 'c':
      link("https://github.com/TechnicJelle/CMGT_Intake/tree/main/ConceptArt");
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
  float x = canvas.width/2;
  float y = canvas.height/2;
  canvas.noFill();
  canvas.stroke(255);
  canvas.strokeWeight(2);
  canvas.ellipseMode(RADIUS);
  canvas.circle(x, y, 64);
  canvas.line(x, y, x + i.x*64, y + i.y*64);
}

void drawGrid() {
  final int TILE_SIZE = 64;
  canvas.stroke(255, 100);
  canvas.strokeWeight(1);
  for (int i = -TILE_SIZE; i < canvas.width+TILE_SIZE; i += TILE_SIZE) {
    canvas.line(i-1, 0, i-1, canvas.height);
  }
  for (int j = -TILE_SIZE; j < canvas.height+TILE_SIZE; j += TILE_SIZE) {
    canvas.line(0, j-1, canvas.width, j-1);
  }
}

boolean random() {
  return random(1)>=0.5f;
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

PVector screenScale(PVector p) {
  if (fullHD)
    return p;
  p = elemmult(p, new PVector(1920, 1080));
  p = elemdiv(p, new PVector(width, height));
  return p;
}
