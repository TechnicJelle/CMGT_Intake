class EntitySprite extends Entity {
  PImage sprite;

  EntitySprite(PVector p, PVector s, String asset) { 
    super(p, s);
    sprite = loadImage(asset);
  }

  void render() {
    pushMatrix();
    translate(pos.x+size.x/2, pos.y+size.y/2);
    rotate(vel.heading());
    image(sprite, -size.x/2, -size.y/2);
    popMatrix();
  }

  void changeSize(int newSize) {
    sprite.resize(newSize, newSize);
    super.size = new PVector(sprite.width, sprite.height);
  }
}
