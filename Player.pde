class Player extends Entity {
  float speed = 2;
  float dampeningFac = 0.8;

  boolean onScreen = true;
  PImage sprite;

  Player(float x, float y) {
    super(new PVector(x, y), new PVector(0, 0));
    sprite = loadImage("Hat.png");
  }

  void update() {
    vel.mult(dampeningFac);
    onScreen = pos.x > -size.x*1.5 && pos.x < width+size.x*1.5 && pos.y > -size.y*1.5 && pos.y < height+size.y*1.5;

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

    vel.add(acc);

    for (int i = 0; i < walls.size(); i++) {
      Collision c = DynamicEntityVsEntity(this, walls.get(i));
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
    //super.render();
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
