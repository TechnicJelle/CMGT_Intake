class Player extends Entity {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;
  PImage sprite;

  boolean colliding = false;

  Player(float x, float y) {
    super(new PVector(x, y), new PVector(0, 0));
    sprite = loadImage("/Environments/Hat.png");
  }

  void update() {
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x && pos.x < width+size.x && pos.y > -size.y && pos.y < height+size.y;

    if (keyPressed) {
      ctrlInput = new PVector((btnCtrlLeft ? -1 : (btnCtrlRight ? 1 : 0)), (btnCtrlTop ? -1 : (btnCtrlBottom ? 1 : 0))).limit(1);
      applyForce(ctrlInput.mult(speed));
      if (btnDash) {
        btnDash = false;
        if (LEVEL != "cabin")
          applyForce(PVector.mult(vel, speed*2));
      }
      //drawInput(ctrlInput);
    }

    colliding = false;
    for (int i = 0; i < walls.size(); i++) {
      Entity w = walls.get(i);
      if (isAabbCollision(this, w)) {
        colliding = true;
      }
    }

    super.update();
  }

  void render() {
    super.render();
    if (colliding)
      rect(pos.x, pos.y, 10, 10);
    //fill(255, 0, 0);
    //noStroke();
    //ellipseMode(CORNER);
    //ellipse(pos.x, pos.y, size.x, size.y);
    pushMatrix();
    translate(pos.x+sprite.width/2, pos.y+sprite.height/2);
    rotate(vel.heading());
    image(sprite, -sprite.width/2, -sprite.height/2);
    popMatrix();
  }

  void changeSize(int newSize) {
    sprite.resize(newSize, newSize);
    super.size = new PVector(sprite.width, sprite.height);
  }
}
