
// x: -900, y: -1025, z: 1400
void addTower(int x, int y, int z) {
  for (int i = x; i <= x + 300; i += 100) {
    for (int j = y; j >= y - 200; j -= 100) {
      for (int k = z; k < z + 400; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  rBlocks.add(new Rectangular(x - 25, y - 400, z - 75, 49, 299, 49, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x + 325, y - 400, z - 75, 49, 299, 49, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x + 325, y - 400, z + 275, 49, 299, 49, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x - 25, y - 400, z + 275, 49, 299, 49, 30, blockSat, 360, 1));
  for (int i = x + 75; i <= x + 275; i += 150) {
    for (int k = z; k < z + 300; k += 100) {
      rBlocks.add(new Rectangular(i, -1325, k, 149, 99, 99, 0, 0, 90, 1));
    }
  }
  for (int i = x + 75; i <= x + 275; i += 150) {
    for (int k = z + 50; k < z + 250; k += 100) {
      rBlocks.add(new Rectangular(i, -1425, k, 149, 99, 99, 0, 0, 90, 1));
    }
  }
  rBlocks.add(new Rectangular(x + 150, y - 275, z - 85, 349, 49, 19, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x + 150, y - 275, z + 285, 349, 49, 19, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x - 35, y - 275, z + 100, 19, 49, 349, 30, blockSat, 360, 1));
  rBlocks.add(new Rectangular(x + 335, y - 275, z + 100, 19, 49, 349, 30, blockSat, 360, 1));
}

// x: -925, y: -1625, z: 1325
void drawTower(int x, int y, int z) {
  if (exploded) {
    fill(30, blockSat, 360, towerAlpha);
  } else {
    fill(30, blockSat, 360, blockAlpha);
  }
  if (outline) {
    stroke(1);
  } else {
    noStroke();
  }
  if (exploded) {
    noStroke();
  }
  pushMatrix();
  translate(x, y, z);
  rotateX(PI/2);
  drawCylinder(8, 25, 5, 100);
  rotateX(-PI/2);
  translate(-x, -y, -z);
  translate(x, y, z + 350);
  rotateX(PI/2);
  drawCylinder(8, 25, 5, 100);
  rotateX(-PI/2);
  translate(-x, -y, -z - 350);
  translate(x + 350, y, z);
  rotateX(PI/2);
  drawCylinder(8, 25, 5, 100);
  rotateX(-PI/2);
  translate(-x - 350, -y, -z);
  translate(x + 350, y, z + 350);
  rotateX(PI/2);
  drawCylinder(8, 25, 5, 100);
  popMatrix();
}

//x:-400, y: -1000, iz: -2200, fz: 1300);
void addVerticalRoof(int x, int y, int iz, int fz) {
  for (int i = x - 200; i <= x + 200; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
  for (int i = x - 150; i <= x + 150; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y - 50, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
  for (int i = x - 100; i <= x + 100; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y - 100, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
}
void addVerticalRoof2(int x, int y, int iz, int fz) {
  for (int i = x - 150; i <= x + 150; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
  for (int i = x - 100; i <= x + 100; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y - 50, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
  for (int i = x - 50; i <= x + 50; i += 100) {
    for (int k = iz; k < fz; k += 200) {
      rBlocks.add(new Rectangular(i, y - 100, k, 99, 49, 199, 0, 0, 90, 1));
    }
  }
}

//addHorizontalRoof(-50, 2550, -1000, -450);
void addHorizontalRoof(int ix, int fx, int y, int z) {
  for (int i = ix; i <= fx; i += 200) {
    for (int k = z - 200; k < z + 200; k += 100) {
      rBlocks.add(new Rectangular(i, y, k, 199, 49, 99, 0, 0, 90, 1));
    }
  }
  for (int i = ix; i <= fx; i += 200) {
    for (int k = z - 150; k < z + 150; k += 100) {
      rBlocks.add(new Rectangular(i, y - 50, k, 199, 49, 99, 0, 0, 90, 1));
    }
  }
  for (int i = ix; i <= fx; i += 200) {
    for (int k = z - 100; k < z + 100; k += 100) {
      rBlocks.add(new Rectangular(i, y - 100, k, 199, 49, 99, 0, 0, 90, 1));
    }
  }
}

void drawCylinder(int sides, float r1, float r2, float h) {
  float angle = 360 / sides;
  float halfHeight = h / 2;

  // draw top of the tube
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r1;
    float y = sin( radians( i * angle ) ) * r1;
    vertex( x, y, -halfHeight);
  }
  endShape(CLOSE);

  // draw bottom of the tube
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r2;
    float y = sin( radians( i * angle ) ) * r2;
    vertex( x, y, halfHeight);
  }
  endShape(CLOSE);

  // draw sides
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x1 = cos( radians( i * angle ) ) * r1;
    float y1 = sin( radians( i * angle ) ) * r1;
    float x2 = cos( radians( i * angle ) ) * r2;
    float y2 = sin( radians( i * angle ) ) * r2;
    vertex( x1, y1, -halfHeight);
    vertex( x2, y2, halfHeight);
  }
  endShape(CLOSE);
}

//void drawTriangle() {
//  stroke(0);
//  strokeWeight(1);
//  beginShape(TRIANGLES);
//  fill(30, 120, 360);
//  //vertex(2650, -3225, 2650);
//  //vertex(2750, -3525, 2750);
//  //vertex(2650, -3225, 2850);
//  vertex(500, 500, 500);
//  vertex(900, 500, 900);
//  vertex(900, 500, 500);

//  endShape();
//}
