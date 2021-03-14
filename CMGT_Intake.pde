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

boolean ctrlTop = false;
boolean ctrlBottom = false;
boolean ctrlLeft = false;
boolean ctrlRight = false;

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    }
  } else {
    switch(key) {
    case 'w':
      ctrlTop = true;
      break;
    case 's':
      ctrlBottom = true;
      break;
    case 'a':
      ctrlLeft = true;
      break;
    case 'd':
      ctrlRight = true;
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
      ctrlTop = false;
      break;
    case 's':
      ctrlBottom = false;
      break;
    case 'a':
      ctrlLeft = false;
      break;
    case 'd':
      ctrlRight = false;
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
