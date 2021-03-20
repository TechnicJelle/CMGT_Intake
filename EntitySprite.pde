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
    canvas.pushMatrix();
    canvas.translate(pos.x + size.x/2, pos.y + size.y/2);
    canvas.rotate(vel.heading());
    canvas.image(sprite, -size.x/2, -size.y/2);
    canvas.popMatrix();
  }

  void changeSize(int newSizeX, int newSizeY) {
    sprite.resize(newSizeX, newSizeY);
    size = new PVector(sprite.width, sprite.height);
  }

  void changeSize(int newSize) {
    changeSize(newSize, int(size.y/size.x*newSize));
  }
}
