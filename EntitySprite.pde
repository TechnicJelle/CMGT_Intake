class EntitySprite extends Entity {
  PImage sprite;

  EntitySprite(PVector p, PVector s, String asset) { 
    super(p, s);
    sprite = loadImage(asset);
  }
  EntitySprite(float x, float y, int sx, int sy, String asset) { 
    super(new PVector(x, y), new PVector(0, 0));
    sprite = loadImage(asset);
    changeSize(sx, sy);
  }

  void render() {
    pushMatrix();
    translate(pos.x+size.x/2, pos.y+size.y/2);
    rotate(vel.heading());
    image(sprite, -size.x/2, -size.y/2);
    popMatrix();
  }

  void changeSize(int newSizeX, int newSizeY) {
    sprite.resize(newSizeX, newSizeY);
    super.size = new PVector(sprite.width, sprite.height);
  }
}
