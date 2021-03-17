class Player extends EntitySprite {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;

  boolean mayDash = true;
  int millisAtDash = -1;

  boolean hasSword = false;

  Player(float x, float y) {
    super(x, y, "Hat.png", ENTITY_TYPE.PLAYER);
  }

  void update() {
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x*1.5 && pos.x < width+size.x*1.5 && pos.y > -size.y*1.5 && pos.y < height+size.y*1.5;

    if (keyPressed) {
      ctrlInput = new PVector((btnCtrlLeft ? -1 : (btnCtrlRight ? 1 : 0)), (btnCtrlTop ? -1 : (btnCtrlBottom ? 1 : 0))).limit(1);
      applyForce(ctrlInput.mult(speed));
      if (LEVEL != LEVELS.CABIN && mayDash) {
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

    for (int i = obstacles.size() - 1; i > 0; i--) {
      Entity o = obstacles.get(i);
      if (o.TYPE == ENTITY_TYPE.WALL || o.TYPE == ENTITY_TYPE.TEMPWALL || o.TYPE == ENTITY_TYPE.OBSTACLE
        || o.TYPE == ENTITY_TYPE.ENEMY || o.TYPE == ENTITY_TYPE.SWORD) {
        Collision c = DynamicEntityVsEntity(this, o);
        if (c.result) {
          if (o.TYPE == ENTITY_TYPE.SWORD) {
            hasSword = true;
            obstacles.remove(i);
          } else {
            //mult(0);
            vel.add(elemmult(c.contact_normal, new PVector(abs(vel.x), abs(vel.y))));
            //vel.add(PVector.mult(elemmult(c.contact_normal, new PVector(abs(vel.x), abs(vel.y))), (1 - c.t_hit_near)));
          }
        }
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
      ellipse(0, 0, size.x, size.x);
    }
  }
}
