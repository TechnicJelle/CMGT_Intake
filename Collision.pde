class Collision {
  boolean result;
  PVector contact_point;
  PVector contact_normal;
  float t_hit_near;
  Collision(boolean r, PVector cp, PVector cn, float thn) {
    result = r;
    contact_point = cp;
    contact_normal = cn;
    t_hit_near = thn;
  }

  Collision (boolean r) {
    result = r;
  }
}

Collision RayVsEntity(PVector ray_origin, PVector ray_dir, Entity target) {
  //additional returns
  PVector contact_point;
  PVector contact_normal = new PVector(-1, -1);
  float t_hit_near;

  PVector t_near = new PVector(
    (target.pos.x - ray_origin.x) / ray_dir.x, 
    (target.pos.y - ray_origin.y) / ray_dir.y);
  PVector t_far = new PVector(
    (target.pos.x + target.size.x - ray_origin.x) / ray_dir.x, 
    (target.pos.y + target.size.y - ray_origin.y) / ray_dir.y);

  if (Float.isNaN(t_far.y) || Float.isNaN(t_far.x)) return new Collision(false);
  if (Float.isNaN(t_near.y) || Float.isNaN(t_near.x)) return new Collision(false);

  if (t_near.x > t_far.x) {
    float temp = t_near.x;
    t_near.x = t_far.x;
    t_far.x = temp;
  }
  if (t_near.y > t_far.y) {
    float temp = t_near.y;
    t_near.y = t_far.y;
    t_far.y = temp;
  }

  if (t_near.x > t_far.y || t_near.y > t_far.x) return new Collision(false);

  t_hit_near = max(t_near.x, t_near.y);
  float t_hit_far = min(t_far.x, t_far.y);

  if (t_hit_far < 0.0f) return new Collision(false);

  contact_point = PVector.add(ray_origin, PVector.mult(ray_dir, t_hit_near));

  if (t_near.x > t_near.y)
    if (ray_dir.x < 0)
      contact_normal = new PVector( 1, 0 );
    else
      contact_normal = new PVector( -1, 0 );
  else if (t_near.x < t_near.y)
    if (ray_dir.y < 0)
      contact_normal = new PVector( 0, 1 );
    else
      contact_normal = new PVector( 0, -1 );


  return new Collision(true, contact_point, contact_normal, t_hit_near);
}

Collision DynamicEntityVsEntity(Entity in, Entity target) { //returns PVector contact_point, PVector contact_normal, float fTime
  boolean ret = false;
  if (in.vel.x == 0 && in.vel.y == 0)
    return new Collision(false);

  Entity extended_target = new Entity(PVector.sub(target.pos, PVector.div(in.size, 2)), PVector.add(target.size, in.size), ENTITY_TYPE.TEMP);
  Collision c = RayVsEntity(PVector.add(in.pos, PVector.div(in.size, 2)), in.vel, extended_target);
  if (c.result) {
    if (c.t_hit_near <= 1.0f)
      ret = true;
    else
      return new Collision(false);
  }
  return new Collision(ret, c.contact_point, c.contact_normal, c.t_hit_near);
}

PVector elemmult(PVector a, PVector b) {
  return new PVector(a.x * b.x, a.y * b.y);
}

PVector elemdiv(PVector a, PVector b) {
  float x = 0;
  float y = 0;
  if (a.x != 0.0f && b.x != 0.0f)
    x = a.x / b.x;
  if (a.y != 0.0f && b.y != 0.0f)
    y = a.y / b.y;
  return new PVector(x, y);
}
