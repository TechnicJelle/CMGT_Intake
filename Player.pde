class Player extends Entity {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;

  Player(float x, float y) {
    super(new PVector(x, y), new PVector(64, 64));
  }

  void update() {
    super.update();
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x && pos.x < width+size.x && pos.y > -size.y && pos.y < height+size.y;

    if (keyPressed) {
      ctrlInput = new PVector((ctrlLeft ? -1 : (ctrlRight ? 1 : 0)), (ctrlTop ? -1 : (ctrlBottom ? 1 : 0))).limit(1);
      applyForce(ctrlInput.mult(speed));
      drawInput(ctrlInput);
    }
  }

  void render() {
    super.render();
    fill(255, 0, 0);
    noStroke();
    ellipseMode(CORNER);
    ellipse(pos.x, pos.y, size.x, size.y);
  }
}
