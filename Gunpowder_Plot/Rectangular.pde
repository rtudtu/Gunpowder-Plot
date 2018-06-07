class Rectangular {
  float w, h, d, hue, sat, bri, res;
  float groundMult = 0;
  float airMult = 0;
  PVector location;
  PVector acceleration;
  PVector velocity;

  Rectangular(float x, float y, float z, float w, float h, float d, float hue, float sat, float bri, float res) {
    this.location = new PVector(x, y, z);
    this.acceleration = new PVector(0, 0, 0);
    this.velocity = new PVector(0, 0, 0);
    this.w = w;
    this.h = h;
    this.d = d;
    this.hue = hue;
    this.sat = sat;
    this.bri = bri;
    this.res = res;
    //this.groundMult = random(.7, .8);
    //this.airMult = random(.8, .9);
    this.groundMult = random(.55, .75);
    this.airMult = random(.75, .9);
  }

  void display() {
    fill(hue, sat, bri, blockAlpha);
    if (!exploded) {
      if (outline) {
        stroke(1);
      } else {
        noStroke();
      }
    } else {
      noStroke();
    }
    pushMatrix();
    translate(location.x, location.y, location.z);
    box(w, h, d);
    popMatrix();
  }

  void updateBlock() {
    velocity.add(acceleration);
    location.add(velocity);
    if (location.y + h/2 + velocity.y >= 0) {
      acceleration.mult(groundMult);
      velocity.mult(0.7/res);
    } else {
      acceleration.mult(airMult);
      //acceleration.y *= .9;
      velocity.mult(0.9/res);
    }
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
}
