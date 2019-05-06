public class SmushBall {
  int x, y, size;
  ArrayList<Point> points;
  ArrayList<Hook> hooks;

  public SmushBall(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;

    points = new ArrayList<Point>();
    hooks = new ArrayList<Hook>();

    for (float i = 0; i < TAU; i += PI/12) {
      points.add(new Point(this.size * cos(i) + this.x, this.size * sin(i) + this.y, 10));
    }

    int starting = 0;

    for (int i = 0; i < points.size(); i++) {
      for (int j = starting; j < points.size(); j++) {
        hooks.add(new Hook(points.get(i), points.get(j)));
      }        
      starting++;
    }
  }

  void applyForce(PVector force) {
    for (Point p : points) {
      p.applyForce(force);
    }
  }

  void show() {
    for (Point p : points) p.update();
    for (Hook h : hooks) h.update();

    beginShape();
    noFill();
    stroke(255);
    for (Point p : points) vertex(p.position.x, p.position.y);
    endShape(CLOSE);
  }
}
