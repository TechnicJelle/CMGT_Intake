class Entity {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  PVector size;

  color debugCol;

  Entity(PVector p, PVector s) {
    pos = p.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = 1;
    size = s.copy();
    debugCol = color(random(255), random(255), random(255));
  }

  Entity(float x, float y, float sx, float sy) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = 1;
    size = new PVector(sx, sy);
    debugCol = color(random(255), random(255), random(255));
  }

  void applyForce(PVector f) {
    f.div(mass); //Do take the mass into account in F = m * a  ==>  a = F / m
    acc.add(f);
  }

  void update() {
    //Newtonian Physics Calculation -->
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void render() {
    noFill();
    stroke(debugCol);
    strokeWeight(1);
    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y);
  }
}
