public class Hook {
  private Point p1, p2;
  private float attractionforce = 0.01;//0.03
  private float normalDist;
  private float pdistanceBetweenPoints;
  private float distanceBetweenPoints;

  public Hook(Point p1, Point p2) {
    this.p1 = p1;
    this.p2 = p2;
    this.normalDist = PVector.dist(p1.position, p2.position);
    this.pdistanceBetweenPoints = normalDist;
  }

  public void update() {
    PVector displacement = PVector.sub(p1.position, p2.position);
    distanceBetweenPoints = p1.position.dist(p2.position);

    displacement.normalize();
    PVector dup = displacement.copy();
    displacement.mult(distanceBetweenPoints - normalDist);
    displacement.mult(attractionforce);

    p2.applyForce(displacement);
    p1.applyForce(PVector.sub(new PVector(0, 0), displacement));

    dup.mult(-(distanceBetweenPoints - pdistanceBetweenPoints) * 0.03);

    p1.applyForce(dup);
    p2.applyForce(PVector.sub(new PVector(0, 0), dup));

    pdistanceBetweenPoints = distanceBetweenPoints;
  }

  void odin() {
    update();
    show();
  }

  void show() {
    stroke(255);
    line(p1.position.x, p1.position.y, p2.position.x, p2.position.y);
  }


  public Point getFirstPoint() {
    return this.p1;
  }

  public Point getSecondPoint() {
    return this.p2;
  }

  public float getDistanceBetweenPoints() {
    return this.distanceBetweenPoints ;
  }
}

public class Point {
  PVector acceleration, velocity, position;
  int size;

  public Point(float x, float y, int size) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);

    this.size = size;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    //GRAVITY
    applyForce(new PVector(0, 0.2));

    velocity.add(acceleration);
    position.add(velocity);

    if (position.x > width - size/2 ) {
      velocity.x = velocity.x * -1;
      position.x = width - size/2;
    } else if ((position.x < size/2)) {
      velocity.x = velocity.x * -1;
      position.x = size/2;
    }

    if (position.y > height - size/2) {
      velocity.y *= -0.95;
      position.y = height - size/2;
    } else if (position.y < size/2) {
      velocity.y *= -1;
      position.y = size/2;
    }
    velocity.mult(0.99);

    acceleration.mult(0);
  }

  void show() {
    fill(255);
    ellipse(position.x, position.y, size, size);
  }

  void odin() {
    update();
    show();
  }
}
