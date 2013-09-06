///////////////////////////////////////////
/*
              LIGHTPAINTING

              VERSION 0.1.0
               MIT Licence
*/
//////////////////////////////////////////
  
import processing.video.*;
Capture cam;

int heightWindow, widthWindow, widthFrame, heightFrame;
float buttonW;
int brightLimit, camChoice, indice, timing;
boolean camMode, recordMode, pauseMode, stopMode, deleteMode, saveMode, printMode, symMode, brightMode, resolutionMode;
boolean[] overButton;
boolean[] overResChoice;
String[] cameras;
PImage screen, title;

void setup() {
//  frameRate(5);
  cameras = Capture.list();
  camChoice = 16;
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }
/*  for (int i = 0; i < cameras.length; i++) {
    println(cameras[i]);
    if (cameras[i] == "name=HP Webcam 3110,size=640x480,fps=15/2") {
      camChoice = i;
    }
  }
//  println(camChoice);
*/
  cam = new Capture(this, cameras[camChoice]);
  cam.start(); 
//  println(cam.width+" "+cam.height);
  widthWindow = 800;
  heightWindow = 600;
  widthFrame = 640;
  heightFrame = 480;
  buttonW = 50;
  brightLimit = 250;
  timing = 100;
  indice = 0;
  camMode = true;
  recordMode = false;
  pauseMode = false;
  stopMode = false;
  deleteMode = false;
  saveMode = false;
  printMode = false;
  symMode = false;
  brightMode = false;
  resolutionMode = false;
  overButton = new boolean[20];
  for (int i = 0; i < overButton.length; i++) {
    overButton[i] = false;
  } 
  overResChoice = new boolean[100];
  for (int i = 0; i < overResChoice.length; i++) {
    overResChoice[i] = false;
  }
  fill(255);
  stroke(0);
  strokeWeight(2);
  rectMode(CENTER);
  background(255);
  size(widthWindow, heightWindow);

  title = loadImage("LightPaintingTitre.png");
  image(title, 270, 5);
    
  screen = createImage(widthFrame, heightFrame, RGB);
  screen.loadPixels();
  for (int i = 0; i < screen.pixels.length; i++) {
    screen.pixels[i] = color(0, 0, 0);
  }
}

/////////////////////////// BUTTONS DISPLAY ///////////////////////////////

void recordB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+buttonW, buttonW, buttonW, 10);
  fill(255, 0, 0);
  noStroke();
  ellipse(740, 60+buttonW, buttonW*0.6, buttonW*0.6);
}

void pauseB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+buttonW, buttonW, buttonW, 10);
  fill(0);
  rect(740-buttonW/5, 60+buttonW, buttonW/4, buttonW*0.6);
  rect(740+buttonW/5, 60+buttonW, buttonW/4, buttonW*0.6);
}

void pauseOnScreenB() {
  fill(255, 50);
  rectMode(CENTER);
  stroke(255, 150);
  strokeWeight(2);
  rect(100, 130, buttonW, buttonW, 10);
  fill(255, 150);
  rect(100-buttonW/5,130, buttonW/4, buttonW*0.6);
  rect(100+buttonW/5, 130, buttonW/4, buttonW*0.6);
}

void stopB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+2.5*buttonW, buttonW, buttonW, 10);
  fill(0);
  rect(740, 60+2.5*buttonW, buttonW*0.5, buttonW*0.5);
}

void saveB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+4*buttonW, buttonW, buttonW, 10);
  fill(0);
  rect(740, 60+3.9*buttonW, buttonW/4, buttonW*0.4);
  triangle(740-buttonW/3, 60+4*buttonW, 740+buttonW/3, 60+4*buttonW, 740, 60+4.4*buttonW);
}

void printB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+5.5*buttonW, buttonW, buttonW, 10);
  fill(0);
  rect(740-0.1*buttonW, 60+5.5*buttonW, buttonW/3, buttonW/4);
  triangle(740, 60+5.2*buttonW, 740, 60+5.8*buttonW, 740+0.4*buttonW, 60+5.5*buttonW);
}

void deleteB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+7*buttonW, buttonW, buttonW, 10);
  fill(0);
  stroke(4);
  line(740-0.4*buttonW, 60+6.6*buttonW, 740+0.4*buttonW, 60+7.4*buttonW);
  line(740+0.4*buttonW, 60+6.6*buttonW, 740-0.4*buttonW, 60+7.4*buttonW);
}

void symmetryB() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+8.5*buttonW, buttonW, buttonW, 10);
  fill(0);
  rect(740, 60+8.5*buttonW, buttonW/3, buttonW/4);
  triangle(740+0.2*buttonW, 60+8.2*buttonW, 740+0.2*buttonW, 60+8.8*buttonW, 740+0.4*buttonW, 60+8.5*buttonW);
  triangle(740-0.2*buttonW, 60+8.2*buttonW, 740-0.2*buttonW, 60+8.8*buttonW, 740-0.4*buttonW, 60+8.5*buttonW);
}

void symmetryOnB() {
  fill(0);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  rect(740, 60+8.5*buttonW, buttonW, buttonW, 10);
  fill(255);
  noStroke();
  rect(740, 60+8.5*buttonW, buttonW/3, buttonW/4);
  triangle(740+0.2*buttonW, 60+8.2*buttonW, 740+0.2*buttonW, 60+8.8*buttonW, 740+0.4*buttonW, 60+8.5*buttonW);
  triangle(740-0.2*buttonW, 60+8.2*buttonW, 740-0.2*buttonW, 60+8.8*buttonW, 740-0.4*buttonW, 60+8.5*buttonW);
}

void brightCursor() {
  fill(0);
  stroke(0);
  strokeWeight(2);
  line(40, 570, 295, 570);
  fill(255);
  ellipse(40+brightLimit, 570, 15, 15);
}

void camSelected() {
  fill(255);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  textSize(10);
  textAlign(CENTER, CENTER);
  rect(500, 570, 300, 18, 10);
  fill(0);
  text(cameras[camChoice], 500, 570, 300, 15);
}  

void resetBackground() {
  fill(255);
  noStroke();
  rectMode(CORNER);
  textAlign(CENTER, CENTER);
  rect(680, 60, 120, 540);
  rect(0, 550, 800, 60);
}

void resChoice() {
  rectMode(CENTER);
  stroke(100, 100);
  strokeWeight(1);
  textSize(10);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < cameras.length; i++) {
    if (i < 37) {
      fill(255, 100);
      rect(500, 565-(i+1)*15, 300, 14);
      fill(100, 100);
      text(cameras[i], 500, 565-(i+1)*15, 300, 14);
    }
  }
}

void savedMessage() {
  textSize(40);
  textAlign(CENTER, CENTER);
  fill(255, 100);
  text("Image enregistrée", 360, 270);
}


void noPrintMessage() {
  textSize(40);
  textAlign(CENTER, CENTER);
  fill(255, 100);
  text("Impression impossible", 360, 270);
}

//////////////////////////// MOUSE ZONES ///////////////////////////////////////

boolean bZone(int zoneNb) {
  return ((mouseX >= 740-buttonW/2) && (mouseX <= 740+buttonW/2)
         && (mouseY >= 60+(0.5+1.5*zoneNb)*buttonW) && (mouseY <= 60+(1.5+1.5*zoneNb)*buttonW));
}

boolean cursorZone() {
  return ((mouseX >= 30+brightLimit) && (mouseX <= 50+brightLimit)
         && (mouseY >= 560) && (mouseY <= 580));
}

boolean resolutionZone() {
  return ((mouseX >= 340) && (mouseX <= 560)
         && (mouseY >= 560) && (mouseY <= 580));
}

boolean resChoiceZone(int resNb) {
  return ((mouseX >= 340) && (mouseX <= 560)
         && (mouseY >= 558-(resNb*15)) && (mouseY <= 572-(resNb*15)));
}


////////////////////////// HELP TEXT (INFO BULLES) ////////////////////////////////

void helpText(int zoneNb) {
  textSize(10);
  textAlign(CENTER, CENTER);
  fill(230, 230, 230, 240);
  rectMode(CORNER);
  stroke(0);
  strokeWeight(1);
  switch(zoneNb) {
  case 0:
    rect(740, 62+1.5*buttonW, -60, 18, 5);
    fill(0);
    text("Enregistrer", 740, 62+1.5*buttonW, -60, 15);
    rectMode(CENTER);
    break;
  case 1:
    rect(740, 62+1.5*buttonW, -40, 18, 5);
    fill(0);
    text("Pause", 740, 62+1.5*buttonW, -40, 15);
    rectMode(CENTER);
    break;
  case 2:
    rect(740, 62+3*buttonW, -30, 18, 5);
    fill(0);
    text("Stop", 740, 62+3*buttonW, -30, 15);
    rectMode(CENTER);
    break;
  case 3:
    rect(740, 62+4.5*buttonW, -70, 18, 5);
    fill(0);
    text("Sauvegarder", 740, 62+4.5*buttonW, -70, 15);
    rectMode(CENTER);
    break;
  case 4:
    rect(740, 62+6*buttonW, -50, 18, 5);
    fill(0);
    text("Imprimer", 740, 62+6*buttonW, -50, 15);
    rectMode(CENTER);
    break;
  case 5:
    rect(740, 62+7.5*buttonW, -120, 18, 5);
    fill(0);
    text("Effacer le projet actuel", 740, 62+7.5*buttonW, -120, 15);
    rectMode(CENTER);
    break;
  case 6:
    rect(740, 62+9*buttonW, -170, 18, 5);
    fill(0);
    text("Appliquer une symétrie verticale", 740, 62+9*buttonW, -170, 15);
    rectMode(CENTER);
    break;
  case 7:
    rect(150, 575, 300, 18, 5);
    fill(0);
    text("Seuil de luminosité à partir duquel on garde la lumière", 150, 575, 300, 15);
    rectMode(CENTER);
    break;
  case 8:
    rect(450, 582, 210, 18, 5);
    fill(0);
    text("Webcam selectionnée pour la capture", 450, 582, 210, 15);
    rectMode(CENTER);
    break;
  }
}
  
  
  
  
void draw() {
    
  resetBackground();
                                        // BUTTONS DISPLAY
  brightCursor();
  camSelected();
  if (recordMode) {
    pauseB();
  } else {
    recordB();
  }
  stopB();
  saveB();
  printB();
  deleteB();
  if (symMode) {                                           // SYMMETRY OPTION
    symmetryOnB();
  } else {
    symmetryB();
  }

  if (resolutionMode) {
    resChoice();
  } else {
    if (timing < 100) {
      if (saveMode) {
        savedMessage();
      }
      if (printMode) {
        noPrintMessage();
      }
      timing++;
    } else {
      saveMode = false;
      printMode = false;
    }
    if (cam.available() == true) {                         // CAM DISPLAY
      cam.read();
//      cam.resize(640,480);
      if (camMode) {
        if (symMode) {
          pushMatrix();
          scale(-1, 1);
          image(cam, -(40+widthFrame), 70);
          popMatrix();
        } else {
          image(cam, 40, 70);
        }
      } else {                                                // LIGHT PAINTING MODE
        if (recordMode) {
          cam.loadPixels();
          screen.loadPixels();
          for (int i = 0; i < cam.pixels.length; i++) {
            if ((brightness(cam.pixels[i]) > brightLimit) && (brightness(cam.pixels[i]) > brightness(screen.pixels[i]))) {
              screen.pixels[i] = cam.pixels[i];
            }
          }
          screen.updatePixels();
          if (symMode) {
            pushMatrix();
            scale(-1, 1);
            image(screen, -(40+widthFrame), 70);
            popMatrix();
          } else {
            image(screen, 40, 70);
          }
        } else {                                                // PAUSE MODE
          if (pauseMode) {
            if (symMode) {
              pushMatrix();
              scale(-1, 1);
              image(cam, -(40+widthFrame), 70);
              popMatrix();
            } else {
              image(cam, 40, 70);
            }
            pauseOnScreenB();
          } else {                                                // STOP MODE
            if (symMode) {
              pushMatrix();
              scale(-1, 1);
              image(screen, -(40+widthFrame), 70);
              popMatrix();
            } else {
              image(screen, 40, 70);
            }
          }
        }
      }
    }
  }
      
//  print(frameIndice+" ");
//  cam.save("/videoframes/frame-"+frameIndice+".tga");
//  frameIndice++;

                                                          // HELP TEXT
  if (bZone(0)) {
    if (recordMode) {
      helpText(1);
    } else {
      helpText(0);
    }
  } else {
    if (cursorZone()) {
      helpText(7);
    } else {
      if (resolutionZone()) {
        helpText(8);
      } else {
        for (int i = 1; i < 7; i++) {
          if (bZone(i)) {
            helpText(i+1);
          }
        }
      }
    }
  }
  

}

///////////////////////////////// MOUSE ACTIONS ////////////////////////

void mousePressed(){
  if (bZone(0)) {                                        // RECORD/PAUSE
    if (recordMode) {
      camMode = false;
      recordMode = false;
      pauseMode = true;
//      noLoop();
    } else {
      camMode = false;
      recordMode = true;
      pauseMode = false;
      loop();
    }
  }
  if (bZone(1)) {                                          // STOP
    camMode = false;
    recordMode = false;
    stopMode = true;
    pauseMode = false;
//    noLoop();
  }
  if (bZone(2)) {                                          // SAVE
    camMode = false;
    recordMode = false;
    stopMode = true;
    saveMode = true;
    indice++;
    File f = new File("/Images_enregistrees/LightPaint-"+indice+".png");
    while (f.exists()) {
    f = new File("/Images_enregistrees/LightPaint-"+indice+".png");
    }
    screen.save("/Images_enregistrees/LightPaint-"+indice+".png");
    timing = 0;
//    noLoop();
  }
  if (bZone(3)) {                                          // PRINT
    camMode = false;
    recordMode = false;
    stopMode = true;
    printMode = true;
    timing = 0;
//    noLoop();
  }
  if (bZone(4)) {                                            // DELETE IMAGE
    camMode = true;
    recordMode = false;
    stopMode = false;
    deleteMode = true;
    screen.loadPixels();
    for (int i = 0; i < screen.pixels.length; i++) {
    screen.pixels[i] = color(0, 0, 0);
    }
    loop();
  }
  if (bZone(5)) {                                          // SYMMETRY
    symMode = !symMode;
  }
  if (cursorZone()) {                                      // BRIGHT CURSOR
    brightMode = true;
  }
  if (resolutionZone()) {                                  // RESOLUTION DISPLAY
    resolutionMode = !resolutionMode;
    background(255);
    image(title, 270, 5);
    if (!resolutionMode) {
      cam.stop();
      cam = new Capture(this, cameras[camChoice]);
      cam.start();
//      screen = createImage(cam.width, cam.height, RGB);
      screen.loadPixels();
      for (int i = 0; i < screen.pixels.length; i++) {
        screen.pixels[i] = color(0, 0, 0);
      }
      screen.updatePixels();
      camMode = true;
    } else {
      camMode = false;
      recordMode = false;
      stopMode = true;
    }
  }
  if (resolutionMode) {                                    // RESOLUTION CHOICE
    for (int i = 0; i < cameras.length; i++) {
      if (i < 37) {
        if (resChoiceZone(i+1)) {
          camChoice = i;
        }
      }
    }
//    resolutionMode = false;
    camMode = true;
    recordMode = false;
    stopMode = false;
  }
}

void mouseReleased(){
  if (brightMode) {
    brightMode = false;
  }
}

  
void mouseDragged(){
  if (brightMode) {                                // BRIGHT CURSOR DRAG
    if ((mouseX >= 40) && (mouseX <= 295)) {
      brightLimit = mouseX - 40;
    } else {
      if (mouseX < 40) {
        brightLimit = 0;
      } else {
        brightLimit = 254;
      }
    }
  }  
}

/////////////////////// KEYBOARD ACTIONS ////////////////////////////

void keyPressed() { 
  if (key == ' ') {                                // RECORD/PAUSE ON SPACEBAR
    if (recordMode) {
      camMode = true;
      recordMode = false;
      pauseMode = true;
//      noLoop();
    } else {
      camMode = false;
      recordMode = true;
      pauseMode = false;
      loop();
    }
  }
}
