/*******************************************************************************
 * Written By: Richard Tu             // Email: tu.r@husky.neu.edu
 * Title: Gunpowder Plot Simulation   // Date: May 31, 2018
 * Description: 
 * Controls:
 ******************************************************************************/
PVector gravityVec = new PVector(0, 9, 0);  //Strength of gravity 

PFont font;                                 //font placeholder

int rotateCountX = 0;                       //Rotate angle X
int rotateCountY = 0;                       //Rotate angle Y
int riverHue = 125;
int riverSat = 360;
int riverBri = 360;
int towerAlpha = 255;

float eMult = .5;
float lVec = 0;
float blockAlpha = 255;
float blockSat = 180;
float explosionFrame = 999999999;
float explosionVar = 4;
float barrelBri = 255;
float barrelChange = -12;

boolean explode = false;
boolean exploded = false;
boolean outline = true;

//TODO: FIND BETTER AMOUNT FOR FORCE OF GRAVITY AND AIR/GROUND RESISTANCE


ArrayList<Rectangular> rBlocks = new ArrayList<Rectangular>();

void setup() {
  frameRate(5);
  fullScreen(P3D);
  //size(1000, 1000, P3D);  
  font = loadFont("DS-Digital-BoldItalic-100.vlw");
  lVec = 2 * sqrt(width * width + width * width);
  textFont(font);
  colorMode(HSB);
  background(color(0));

  //BRIDGE
  for (int i = -width - 200; i <= width; i+= 200) {
    for (int k = 3285; k <= width; k+= 200) {
      if (k == 3485) {
        if (Math.abs(i) % 400 == 240 || i % 400 == 160) {
          rBlocks.add(new Rectangular(i, -210, k, 199, 20, 99, 40, 230, 230, 3));
        } else {
          rBlocks.add(new Rectangular(i, -210, k, 199, 20, 99, 0, 0, 150, 3));
        }
      } else {
        rBlocks.add(new Rectangular(i, -210, k, 199, 20, 99, 0, 0, 150, 3));
      }
    }
  }  
  for (int i = -width - 100; i <= width; i+= 200) {
    for (int k = 3185; k <= width; k+= 200) {
      rBlocks.add(new Rectangular(i, -210, k, 199, 20, 99, 0, 0, 150, 3));
    }
  }

  for (int i = -width; i <= -1000; i+= 400) {
    for (int k = 3185; k <= width; k+= 100) {
      rBlocks.add(new Rectangular(i, -55, k, 80, 110, 99, 80, blockSat, 150, 3));
      rBlocks.add(new Rectangular(i, -120, k, 100, 20, 99, 80, blockSat, 150, 3));
      rBlocks.add(new Rectangular(i, -140, k, 130, 20, 99, 80, blockSat, 150, 3));
      rBlocks.add(new Rectangular(i, -160, k, 180, 20, 99, 80, blockSat, 150, 3));
      rBlocks.add(new Rectangular(i, -180, k, 280, 20, 99, 80, blockSat, 150, 3));
      rBlocks.add(new Rectangular(i, -195, k, 400, 10, 99, 80, blockSat, 150, 3));
    }
  }
  //rBlocks.add(new Rectangular((-width - 1000)/2, -195, 3450, width - 1000, 10, 760, 80, 150, 150, 1));

  //PARLIAMENT
  //Front back->forth
  addTower(-900, -1025, 1400);
  addTower(-900, -1025, 2200);
  addTower(-900, -1025, -2600);
  addTower(-900, -1025, -3400);
  addVerticalRoof(-400, -1000, -2200, -1600);
  addTower(-600, -1025, -1600);
  addVerticalRoof(-400, -1000, -1200, 400);
  addTower(-600, -1025, 400);
  addVerticalRoof(-400, -1000, 800, 1400);

  addVerticalRoof2(-750, -1000, 1800, 2200);
  addVerticalRoof2(-50, -1000, 1400, 2600);
  addVerticalRoof2(-350, -1000, 1400, 1800);
  addVerticalRoof2(-350, -1000, 2200, 2600);

  addVerticalRoof2(-750, -1000, -3000, -2600);
  addVerticalRoof2(-50, -1000, -3400, -2200);
  addVerticalRoof2(-350, -1000, -3400, -3000);
  addVerticalRoof2(-350, -1000, -2600, -2200);
  for (int i = -600; i <= -200; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -2600; k < 1700; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = -500; i <= -300; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 2200; k < 2500; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = -500; i <= -300; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -3100; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  //Front left tower left->right
  for (int i = -200; i <= 100; i+= 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 1400; k < 2500; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = -900; i <= -600; i+= 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 1400; k < 2500; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  //Back left tower left->right
  for (int i = -200; i <= 100; i+= 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -2300; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = -900; i <= -600; i+= 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -2300; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  //Middle left->right(s)
  addHorizontalRoof(-50, 2450, -1000, -450);
  addHorizontalRoof(-150, 2550, -1000, -1450);
  addHorizontalRoof(-150, 2550, -1000, 550);
  addHorizontalRoof(250, 2550, -1000, -3250);
  addHorizontalRoof(250, 2550, -1000, 2350);
  for (int i = 200; i <= 2500; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 2200; k < 2500; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = -100; i <= 2500; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 400; k < 700; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = -100; i <= 2500; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -1600; k < -1300; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = 200; i <= 2500; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -3100; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = -100; i <= 2400; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -600; k < -200; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 150, blockSat, 360, 1));
      }
    }
  }
  //Middle back->forth
  addVerticalRoof(2800, -1000, -3400, -800);
  addVerticalRoof(2800, -1000, 0, 2600);
  for (int i = 2600; i <= 3000; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -2200; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
    for (int i = 2600; i <= 3000; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -2200; k < -800; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 0, blockSat, 360, 1));
      }
    }
  }
  for (int i = 2600; i <= 3000; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 0; k < 2500; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }
  //Back left->right(s)
  addHorizontalRoof(3150, 3850, -1000, -450);
  addHorizontalRoof(3150, 3850, -1000, -1450);
  addHorizontalRoof(3150, 3850, -1000, 550);
  addHorizontalRoof(3150, 3650, -1000, -3250);
  for (int i = 3100; i <= width; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = 400; k < 700; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = 3100; i <= width; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -1600; k < -1300; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = 3100; i <= 3500; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -3400; k < -3100; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 30, blockSat, 360, 1));
      }
    }
  }  
  for (int i = 3200; i <= width; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -600; k < -200; k += 200) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 199, 150, blockSat, 360, 1));
      }
    }
  }
  //CENTRAL TOWER
  for (int i = 2500; i <= 3100; i += 100) {
    for (int j = -225; j >= -925; j -= 100) {
      for (int k = -850; k < -50; k += 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 80, blockSat, 360, 1));
      }
    }
  }
  for (int i = 2550; i <= 3050; i += 100) {
    for (int k = -800; k < -100; k += 100) {
      rBlocks.add(new Rectangular(i, -1025, k, 99, 99, 99, 80, blockSat, 360, 1));
    }
  }
  for (int i = 2600; i <= 3000; i += 100) {
    for (int k = -750; k < -150; k += 100) {
      rBlocks.add(new Rectangular(i, -1075, k, 99, 99, 99, 80, blockSat, 360, 1));
    }
  }
  for (int i = 2650; i <= 2950; i += 100) {
    for (int j = -1125; j >= -1825; j -= 100) {
      for (int k = -700; k < -200; k += 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 80, blockSat, 360, 1));
      }
    }
  }
  for (int i = 2700; i <= 2900; i += 100) {
    for (int k = -650; k < -250; k += 100) {
      rBlocks.add(new Rectangular(i, -1875, k, 99, 99, 99, 80, blockSat, 360, 1));
    }
  }
  for (int i = 2750; i <= 2850; i += 100) {
    for (int j = -1925; j >= -2225; j -= 100) {
      for (int k = -600; k < -300; k += 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 80, blockSat, 360, 1));
      }
    }
  }
  //VICTORIA TOWER
  for (int i = 3600; i <= 3800; i += 100) {
    for (int j = -225; j >= -2925; j -= 100) {
      for (int k = -3750; k < -2750; k += 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 190, blockSat, 360, 1));
      }
    }
  }
  rBlocks.add(new Rectangular(3560, -3050, -3300, 19, 149, 799, 190, blockSat, 360, 1));
  rBlocks.add(new Rectangular(3700, -3050, -2810, 299, 149, 19, 190, blockSat, 360, 1));
  rBlocks.add(new Rectangular(3700, -3050, -3790, 299, 149, 19, 190, blockSat, 360, 1));
  //BIG BEN
  for (int i = 2600; i < 3100; i+= 100) {
    for (int j = -225; j >= -2025; j-= 100) {
      for (int k = 2550; k < 3050; k+= 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = 2550; i < 3150; i+= 100) {
    for (int j = -2125; j >= -2625; j-= 100) {
      for (int k = 2500; k < 3100; k+= 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 30, blockSat, 360, 1));
      }
    }
  }
  for (int i = 2600; i < 3100; i+= 100) {
    for (int k = 2550; k < 3050; k+= 100) {
      rBlocks.add(new Rectangular(i, -2725, k, 99, 99, 99, 0, 0, 90, 1));
    }
  }
  for (int i = 2650; i < 3050; i+= 100) {
    for (int k = 2600; k < 3000; k+= 100) {
      rBlocks.add(new Rectangular(i, -2825, k, 99, 99, 99, 0, 0, 90, 1));
    }
  }
  for (int i = 2700; i < 3000; i+= 100) {
    for (int k = 2650; k < 2950; k+= 100) {
      rBlocks.add(new Rectangular(i, -2925, k, 99, 99, 99, 0, 0, 90, 1));
    }
  }
  for (int i = 2750; i < 2950; i+= 100) {
    for (int j = -3025; j >= -3125; j-= 100) {
      for (int k = 2700; k < 2900; k+= 100) {
        rBlocks.add(new Rectangular(i, j, k, 99, 99, 99, 30, blockSat, 360, 1));
      }
    }
  }
  rBlocks.add(new Rectangular(2800, -3150, 2750, 180, 50, 180, 0, 0, 90, 1));
  rBlocks.add(new Rectangular(2800, -3200, 2750, 150, 50, 150, 0, 0, 90, 1));
  rBlocks.add(new Rectangular(2800, -3250, 2750, 120, 50, 120, 0, 0, 90, 1));
  rBlocks.add(new Rectangular(2800, -3300, 2750, 90, 50, 90, 0, 0, 90, 1));
  rBlocks.add(new Rectangular(2800, -3350, 2750, 60, 50, 60, 0, 0, 90, 1));
  rBlocks.add(new Rectangular(2800, -3400, 2750, 30, 50, 30, 0, 0, 90, 1));
}

void draw() {
  //Background color
  background(30);
  lights();
  colorMode(RGB);
  ambientLight(60, 60, 60);
  colorMode(HSB);
  //pushMatrix();
  translate(width/2, height * 1.1, -width);
  //popMatrix();

  //Rotate screenY
  rotateY(rotateCountY * .004);

  //Rotate screenX
  rotateX(rotateCountX * .004);

  //text(blockAlpha, 500, -1000, 0);

  //Floor
  fill(120);
  stroke(360);
  strokeWeight(1);
  beginShape();
  vertex(-width, 0, -width);
  vertex(width, 0, -width);
  vertex(width, 0, width);
  vertex(-width, 0, width);
  endShape(CLOSE);

  //Ground
  fill(120);
  stroke(0);
  strokeWeight(1);
  pushMatrix();
  translate((-1000 + width)/2, -100, 0);
  box(1000 + width, 200, width * 2);
  popMatrix();


  //Guides
  //textSize(200);
  //fill(200);
  //text(-width, -width, 0, 0);
  //text(-height, 0, -height, 0);
  //text(-width, 0, 0, -width);
  //text(width, width, 0, 0);
  //text(height, 0, height, 0);
  //text(width, 0, 0, width);
  //text("0", 0, 0, 0);
  //text(frameRate, 0, -2500, -1000);

  //Draw River
  noStroke();
  for (int i = 0; i <= 100; i++) {
    int offset = Math.abs((frameCount/5 - i) % 5);
    fill(riverHue + offset, 360, 360);
    beginShape();
    vertex(-width, -1, -width + (2*width)/100 * i);
    vertex(-1000, -1, -width + (2*width)/100 * i);
    vertex(-1000, -1, -width + (2*width)/100 * (i + 1));
    vertex(-width, -1, -width + (2*width)/100 * (i + 1));
    endShape(CLOSE);
  }

  if (exploded) {
    fill(80, blockSat, 360, towerAlpha);
  } else {
    fill(80, blockSat, 360, blockAlpha);
  }
  if (outline) {
    stroke(1);
  } else {
    noStroke();
  }
  if (exploded) {
    noStroke();
  }
  if (towerAlpha > 0) {
    //Central
    pushMatrix();
    translate(2800, -2375, -500);
    rotateX(PI/2);
    drawCylinder(14, 100, 50, 200);
    popMatrix();
    pushMatrix();
    translate(2800, -2725, -500);
    rotateX(PI/2);
    drawCylinder(14, 50, 5, 500);
    popMatrix();
    //Victoria
    if (exploded) {
      fill(190, blockSat, 360, towerAlpha);
    } else {
      fill(190, blockSat, 360, blockAlpha);
    }
    pushMatrix();
    translate(3600, -1800, -2850);
    rotateX(PI/2);
    drawCylinder(10, 90, 90, 3250);
    popMatrix();
    pushMatrix();
    translate(3600, -1800, -3750);
    rotateX(PI/2);
    drawCylinder(10, 90, 90, 3250);
    popMatrix();
    pushMatrix();
    translate(3600, -3550, -2850);
    rotateX(PI/2);
    drawCylinder(10, 90, 5, 250);
    popMatrix();
    pushMatrix();
    translate(3600, -3550, -3750);
    rotateX(PI/2);
    drawCylinder(10, 90, 5, 250);
    popMatrix();
    //Gunpowder Barrels
    fill(0, barrelBri, barrelBri, towerAlpha);
    stroke(1);
    if (exploded) {
      noStroke();
    }
    pushMatrix();
    translate(2625, -400, -1050);
    rotateX(PI/2);
    for (int i = 0; i < 4; i++) {
      translate(i * 120, 0, -0);
      for (int k = 0; k < 9; k++) {
        translate(0, -120, 0);
        drawCylinder(16, 50, 50, 150);
      }
      translate(-i * 120, 9 * 120, 0);
    }
    popMatrix();
    if (!exploded) {
      if (barrelBri < 150) {
        barrelChange *= -1;
      }
      if (barrelBri > 340) {
        barrelChange *= -1;
      }
      barrelBri += barrelChange;
    }
  }

  if (!exploded) {
    for (int i = 0; i < rBlocks.size(); i++) {
      rBlocks.get(i).display();
    }
  } else {
    for (int i = 0; i < rBlocks.size(); i++) {
      Rectangular block = rBlocks.get(i);
      boolean blockBeneath = false;
      if (block.location.y + block.h/2 + block.velocity.y >= 0 &&
        block.location.x < -1000 && 
        block.location.x > -width &&
        block.location.z < width &&
        block.location.z > -width) {
        block.location.y = -block.h/2;
        block.velocity.y = 0;
        block.acceleration.y = 0;
      } else if (block.location.y + block.h/2 + block.velocity.y >= -200 &&
        block.location.x >= -1000 &&
        block.location.x < width &&
        block.location.z < width &&
        block.location.z > -width) {
        block.location.y = -block.h/2 - 200;
        block.velocity.y = 0;
        block.acceleration.y = 0;
      }
      //if (!exploded) {
      for (int j = 0; j < rBlocks.size(); j++) {
        Rectangular block2 = rBlocks.get(j);
        if (block.equals(block2)) {
          continue;
        }
        if (block2.location.y < block.location.y) {
          continue;
        }
        if (block.location.y + block.h/2 <= block2.location.y + block2.h/4 &&
          block.location.y + block.h/2 >= block2.location.y - block2.h/2 - 10 &&
          block.location.x + block.w/2 >= block2.location.x - block2.w/2 &&
          block.location.x - block.w/2 <= block2.location.x + block2.w/2 &&
          block.location.z + block.d/2 >= block2.location.z - block2.d/2 &&
          block.location.z - block.d/2 <= block2.location.z + block2.d/2) {
          block.location.y = block2.location.y - block2.h/2 - block.h/2;
          //block.velocity.y = 0;
          //block.acceleration.y = 0;
          blockBeneath = true;
          break;
        }
      }
      //}
      if (!blockBeneath && frameCount > explosionFrame) {
        block.applyForce(gravityVec);
      }
      block.updateBlock();
      block.display();
    }
  }

  if (frameCount == explosionFrame && explode) {
    float bx = 2100, by = -200, bz = -600;
    for (int i = 0; i < rBlocks.size(); i++) {
      Rectangular block = rBlocks.get(i);
      float ex = 0, ey = 0, ez = 0;
      float scale, angle;
      ex = block.location.x - bx;
      ey = block.location.y - by;
      ez = block.location.z - bz;
      scale = sqrt(ex * ex + ez * ez);
      scale = lVec - scale;
      scale /= 100;
      scale *= eMult;
      if (ez >= 0) {
        angle = atan(ex/ez);
        ex = sin(angle) * scale;
        ez = cos(angle) * scale;
        ey = lVec/2 - abs(ey);
        ey /= 150;
        ey *= eMult;
        //println("ex: " + ex + "|| ey: " + ey + "|| ez: " + ez);
        PVector accel = new PVector(ex + random(-explosionVar, explosionVar), 
          -ey + random(-explosionVar, explosionVar), ez + random(-explosionVar, explosionVar));
        block.acceleration.add(accel);
      } else {
        angle = atan(ex/ez);
        ex = sin(angle) * scale;
        ez = cos(angle) * scale;
        ey = lVec/2 - abs(ey);
        ey /= 150;
        ey *= eMult;
        PVector accel = new PVector(-ex + random(-explosionVar, explosionVar), 
          -ey + random(-explosionVar, explosionVar), -ez + random(-explosionVar, explosionVar));
        block.acceleration.add(accel);
      }
    }
    exploded = true;
  }

  if (exploded && towerAlpha > 0) {
    towerAlpha -= 50;
  }
  drawTower(-925, -1625, 1325);
  drawTower(-925, -1625, 2125);
  drawTower(-925, -1625, -2675);
  drawTower(-925, -1625, -3475);
  drawTower(-625, -1625, -1675);
  drawTower(-625, -1625, 325);

  if (frameCount > explosionFrame) {
    for (int i = rBlocks.size() - 1; i >= 0; i--) {
      Rectangular block = rBlocks.get(i);
      if (block.location.y > 200) {
        rBlocks.remove(i);
      }
    }
  }

  if (keyPressed) {
    //If UP/DOWN/RIGHT/LEFT are pressed, rotate screen
    if (keyCode == UP) {
      rotateCountX -= 5;
    }
    if (keyCode == DOWN) {
      rotateCountX += 5;
    }
    if (keyCode == RIGHT) {
      rotateCountY -= 5;
    }
    if (keyCode == LEFT) {
      rotateCountY += 5;
    }
    //If space is pressed, reset to default rotation
    if (key == ' ') {
      rotateCountY = 0;
      rotateCountX = 0;
    }
  }
}

//Listen for key presses
void keyPressed() {
  if (key == '0') {
    for (int i = 0; i < rBlocks.size(); i++) {
      blockAlpha = 255;
    }
  }
  if (key == '-') {
    if (blockAlpha >= -10) {
      blockAlpha -= 5;
    } else {
      blockAlpha = 0;
    }
  }
  if (key == '=') {
    if (blockAlpha <= 255) {
      blockAlpha += 5;
    } else {
      blockAlpha = 255;
    }
  }
  if (key == 'o') {
    if (outline) {
      outline = false;
    } else {
      outline = true;
    }
  }
  if (key == ENTER) {
    explode = true;
    explosionFrame = frameCount + 1;
  }
}
