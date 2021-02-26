class Entity {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  PVector size;

  Entity(PVector p, PVector s) {
    pos = p.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = 1;
    size = s.copy();
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
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y);
  }
}
