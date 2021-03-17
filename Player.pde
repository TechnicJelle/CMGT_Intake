class Player extends EntitySprite {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;

  boolean mayDash = true;
  int millisAtDash = -1;

  Player(float x, float y) {
    super(new PVector(x, y), new PVector(0, 0), "Hat.png");
  }

  void update() {
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x*1.5 && pos.x < width+size.x*1.5 && pos.y > -size.y*1.5 && pos.y < height+size.y*1.5;

    if (keyPressed) {
      ctrlInput = new PVector((btnCtrlLeft ? -1 : (btnCtrlRight ? 1 : 0)), (btnCtrlTop ? -1 : (btnCtrlBottom ? 1 : 0))).limit(1);
      applyForce(ctrlInput.mult(speed));
      if (LEVEL != "cabin" && mayDash) {
        if (btnDash && vel.magSq() > 1) {
          applyForce(PVector.mult(vel, speed*2));
          millisAtDash = millis();
          mayDash = false;
          btnDash = false;
        }
      }
    }
    if (millis() - millisAtDash > 1000)
      mayDash = true;

    //drawInput(ctrlInput);

    vel.add(acc);

    for (int i = 0; i < obstacles.size(); i++) {
      Collision c = DynamicEntityVsEntity(this, obstacles.get(i));
      if (c.result) {
        //vRects.get(0).vel.mult(0);
        vel.add(elemmult(c.contact_normal, new PVector(abs(vel.x), abs(vel.y))));
        //vRects.get(0).vel.add(PVector.mult(elemmult(c.contact_normal, new PVector(abs(vRects.get(0).vel.x), abs(vRects.get(0).vel.y))), (1 - c.t_hit_near)));
      }
    }

    pos.add(vel);
    acc.mult(0);
  }

  void render() {
    super.render();
    if (!mayDash) {
      noStroke();
      fill(255, map(millis() - millisAtDash, 0, 1000, 0, 255));
      ellipse(0, 0, size.x, size.y);
    }
  }

  void changeSize(int newSize) {
    super.changeSize(newSize, newSize);
  }
}
