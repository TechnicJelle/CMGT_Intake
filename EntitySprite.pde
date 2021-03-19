class EntitySprite extends Entity {
  PImage sprite;

  EntitySprite(float x, float y, String asset, int t) { 
    super(new PVector(x, y), new PVector(0, 0), t);
    sprite = loadImage(asset);
    changeSize(sprite.width, sprite.height);
  }

  EntitySprite(float x, float y, String asset, int s, int t) { 
    super(new PVector(x, y), new PVector(0, 0), t);
    sprite = loadImage(asset);
    changeSize(s);
  }

  EntitySprite(float x, float y, String asset, int sx, int sy, int t) { 
    super(new PVector(x, y), new PVector(0, 0), t);
    sprite = loadImage(asset);
    changeSize(sx, sy);
  }

  void render() {
    super.render();
    pushMatrix();
    translate(pos.x + size.x/2, pos.y + size.y/2);
    rotate(vel.heading());
    image(sprite, -size.x/2, -size.y/2);
    popMatrix();
  }

  void changeSize(float newSizeX, float newSizeY) {
    PVector s = new PVector(newSizeX, newSizeY);
    s = screenScale(s);
    sprite.resize(int(s.x), int(s.y));
    size = new PVector(sprite.width, sprite.height);
  }

  void changeSize(float newSize) {
    changeSize(newSize, size.y/size.x*newSize);
  }
}
