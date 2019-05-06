SmushBall ball;

float smashAcceleration = 2;

void setup() {
  fullScreen(2);
  ball = new SmushBall(width/2, height/2, 100);
}

void draw() {
  background(0);

  ball.show();
}

void keyPressed() {
  if (key == 'i') smashAcceleration += 0.1;
  else if (key == 'k') smashAcceleration -= 0.1;
  else {
    if (keyCode == UP) ball.applyForce(new PVector(0, -smashAcceleration));
    if (keyCode == DOWN) ball.applyForce(new PVector(0, smashAcceleration));

    if (keyCode == LEFT) ball.applyForce(new PVector(-smashAcceleration, 0));
    if (keyCode == RIGHT) ball.applyForce(new PVector(smashAcceleration, 0));
  }
}
