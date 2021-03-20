class Entity {
  PVector pos;
  PVector vel;
  PVector acc;
  //float mass;
  PVector size;

  color debugCol;
  int TYPE;

  Entity(PVector p, PVector s, int t) {
    constructor(p, s, t);
  }

  Entity(float x, float y, float sx, float sy, int t) {
    constructor(new PVector(x, y), new PVector(sx, sy), t);
  }

  void constructor(PVector p, PVector s, int t) {
    pos = p.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    //mass = 1;
    size = s.copy();
    debugCol = color(random(100, 255), random(100, 255), random(100, 255));
    TYPE = t;
  }

  void applyForce(PVector f) {
    //f.div(mass); //Do take the mass into account in F = m * a  ==>  a = F / m
    acc.add(f);
  }

  void update() {
    //Newtonian Physics Calculation -->
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void render() {
    canvas.noFill();
    canvas.stroke(debugCol);
    canvas.strokeWeight(1);
    canvas.rectMode(CORNER);
    canvas.rect(pos.x, pos.y, size.x, size.y);
  }
}
