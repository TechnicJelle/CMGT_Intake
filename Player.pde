class Player extends EntitySprite {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;

  boolean mayDash = true;
  int millisAtDash = -1;

  boolean hasSword = false;

  PImage sword = loadImage("SwordWeapon.png");
  boolean swinging = false;
  boolean swingDir = true;
  float swingProgress = -1;
  int millisAtSwing = -1;

  Player(float x, float y) {
    super(x, y, "Hat.png", ENTITY_TYPE.PLAYER);
  }

  void update() {
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x*1.5 && pos.x < canvas.width+size.x*1.5 && pos.y > -size.y*1.5 && pos.y < canvas.height+size.y*1.5;

    if (keyPressed) {
      ctrlInput = new PVector((btnCtrlLeft ? -1 : (btnCtrlRight ? 1 : 0)), (btnCtrlTop ? -1 : (btnCtrlBottom ? 1 : 0))).limit(1);
      //drawInput(ctrlInput);
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

    if (!swinging && btnSwing && hasSword) {
      millisAtSwing = millis();
      swinging = true;
      //btnSwing = false; //One click per swing. Comment out to keep swinging
      //swingDir = random(); //Swing in random direction
      swingDir = !swingDir; //Swing in alternating direction
      setAim();
    }

    if (millis() - millisAtDash > 1000)
      mayDash = true;
    if (millis() - millisAtSwing > SWING_SPEED)
      swinging = false;

    if (swinging) 
      swingProgress = map(millis() - millisAtSwing, 0, SWING_SPEED, 0, 1);

    vel.add(acc);

    for (int i = obstacles.size() - 1; i >= 0; i--) {
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
    if (swinging) {
      canvas.pushMatrix();
      canvas.translate(pos.x + size.x/2, pos.y + size.y/2);
      if (swingDir)
        canvas.rotate(swingProgress * HALF_PI - HALF_PI + aim.heading());
      else
        canvas.rotate((1.0-swingProgress) * HALF_PI - HALF_PI + aim.heading());
      canvas.image(sword, 0, 0);
      canvas.popMatrix();
    }
    super.render();
    if (!mayDash) {
      canvas.noStroke();
      canvas.fill(255, map(millis() - millisAtDash, 0, 1000, 0, 255));
      canvas.circle(0, 0, 150);
    }
  }

  void changeSize(int newSize) {
    super.changeSize(newSize);
    sword.resize(int(size.x), int(size.y));
  }
}
