final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = GAME_START;
int block = 80;
float grX=0;
float grY=160;

PImage Health;
float HealthX= 10;
float newHealthX;
float HealthY= 10;
float HealthPlus= 70;

//the doesn't move groundhog rrrrrrrrr
PImage groundhogImg;
float groundhogX = 4*block;
float groundhogY = block;  
float groundhogXPlus;
float groundhogYPlus;
PImage downImg;
PImage rightImg;
PImage leftImg;
int hogStat;
int timer;
final int GR_NORM=0, GR_DOWN=1, GR_RIGHT=2, GR_LEFT=3;
  
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;
float level=0;

boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhogIdle.png");
  Health = loadImage("img/life.png");
  gameover = loadImage("img/gameover.jpg");
  downImg= loadImage("img/groundhogDown.png");
  rightImg= loadImage("img/groundhogRight.png");
  leftImg= loadImage("img/groundhogLeft.png");
  restartHovered= loadImage("img/restartHovered.png");
  startHovered= loadImage("img/startHovered.png");
  restartNormal= loadImage("img/restartNormal.png");
  startNormal= loadImage("img/startNormal.png");
  title= loadImage("img/title.jpg");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);
   
    //to the new canvas
      pushMatrix();
      if (groundhogY>block){
        translate(0,-block);//to the new center
        }
      
    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int ix=0; ix<8 ;ix++){      
      for(int level=0; level<24 ;level++){
          image(soil5, 0+block*ix, 160+block*level);
        }
      for(int level=0; level<20 ;level++){
          image(soil4, 0+block*ix, 160+block*level);
        }
      for(int level=0; level<16 ;level++){
          image(soil3, 0+block*ix, 160+block*level);
        }
      for(int level=0; level<12 ;level++){
          image(soil2, 0+block*ix, 160+block*level);
        }
      for(int level=0; level<8 ;level++){
          image(soil1, 0+block*ix, 160+block*level);
        }
      for(int level=0; level<4 ;level++){
          image(soil0, 0+block*ix, 160+block*level);
        }
      }


    // Player
/////////////////////////////boundary detection
    if(groundhogY >= height){
    groundhogY = height-block;
    }//down boundary
          
    if(groundhogX >= width){
    groundhogX = width-block;
    }//right boundary
          
    if(groundhogX <= 0){
     groundhogX = 0;
    } //left boundary
    
    //Draw hog
    switch(hogStat){
    case GR_NORM:
      image(groundhogImg,groundhogX,groundhogY);
      break;
    case GR_DOWN:
      image(downImg,groundhogX,groundhogY);
      timer+=1;
      groundhogY+=80.0/15;
      break;
    case GR_RIGHT:
      image(rightImg,groundhogX,groundhogY);
      timer+=1;
      groundhogX+=80.0/15;
      break;
    case GR_LEFT:
      image(leftImg,groundhogX,groundhogY);
      timer+=1;
      groundhogX-=80.0/15;
      break;
    }
    
    popMatrix();
    
    //check timer
    if(timer==15){
      hogStat=GR_NORM;
    if(groundhogY%block<30){//fix float point offset
      groundhogY=groundhogY-groundhogY%block;
      }else{
      groundhogY=groundhogY-groundhogY%block+block;
      }
    if(groundhogX%block<30){
      groundhogX=groundhogX-groundhogX%block;
      }else{
      groundhogX=groundhogX-groundhogX%block+block;
      }
      //println(hogX);
      //println(hogY);
      timer=0;
   }
    
   // Health UI
   for(int i = 0; i< playerHealth; i++){
      image(Health,HealthX+HealthPlus*i, HealthY);
      }  
     break;


    case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        playerHealth=3;
        mousePressed = false;
        // Remember to initialize the game here!
      }
    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here
    if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(groundhogY+block<height&&hogStat==GR_NORM){
          hogStat=GR_DOWN;
          translate(0, cameraOffsetY);
          timer=0;
          level++;
        }
        break;
      case RIGHT:
        if(groundhogX+block<width&&hogStat==GR_NORM){
          hogStat=GR_RIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(groundhogX>0&&hogStat==GR_NORM){
          hogStat=GR_LEFT;
          timer=0;
      break;
    }}
    
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
}

void keyReleased(){
}
