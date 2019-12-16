class Player {

  WavePattern currentWavePattern;

  float posAngle;
  int PLAYER_CENTER_GAP = 30;
  int centerSize;

  PVector pos;  //position of player triangle top
  int playerWidth = 15;
  int playerHeight = 10;

  int currentSection;
  int prevSection;

  color playerCol = color(255, 0, 0);

  boolean isColliding = false;
  boolean collidingAnticlockwise = false;
  boolean collidingClockwise = false;
  boolean collidingBottom = false;


  Player(int centerSize) {

    this.centerSize = centerSize;
    posAngle = random(TWO_PI);
    //posAngle = 0;
    currentSection = (int)( posAngle / (TWO_PI/sections) );
    prevSection = currentSection;
  }


  void checkCollisions() {

    boolean tempIsColliding = false;  // Will change to true only if one obstacle is colliding

    if (currentWavePattern != null && !currentWavePattern.waves.isEmpty()) {  // Can't be colliding if there aren't any obstacles

      for (Wave wav : currentWavePattern.waves) {
        for (Obstacle ob : wav.obstacles) {
          
          if (  ob.section == currentSection &&
                ob.distFromCenter <= pos.y   &&
                ob.distFromCenter + ob.thickness >= pos.y )
          {
            // COLLIDING
            tempIsColliding = true;
            if (ob.distFromCenter >= pos.y - 5) {
              
              collidingBottom = true;
              gameOver = true;
              
              if (timer > easyHighScore && selectedDifficulty == 1) {
                  easyHighScore = timer;
              }
              if (timer > hardHighScore && selectedDifficulty == 2) {
                  hardHighScore = timer;
              }

            }
              
          } 
        }
          
      }
    }
      
  

    isColliding = tempIsColliding;

    if (collidingBottom) {
      collidingClockwise = false;
      collidingAnticlockwise = false;
    } 
    else if (isColliding && (currentSection < prevSection || (currentSection == sections-1 && prevSection == 0))) {
      //System.out.println("COLLIDING WITH WALL ANTICLOCKWISE");
      collidingAnticlockwise = true;
      collidingClockwise = false;
    } 
    else if (isColliding && (currentSection > prevSection || (currentSection == 0 && prevSection == sections-1))) {
      //System.out.println("COLLIDING WITH WALL CLOCKWISE");
      collidingClockwise = true;
      collidingAnticlockwise = false;
    } 
    else {
      collidingClockwise = false;
      collidingAnticlockwise = false;
    }


    // Update Player Color on Collision
    // if (isColliding) {
    //   playerCol = color(0,255,255);
    // }
    // else {
    //   playerCol = color(255,0,0);
    // }
  }


  void update(String dir, int centerSize, WavePattern currentWavePattern) {

    //UPDATE PLAYER'S CURRENT SECTION
    int calculatedSection = (int)( posAngle / (TWO_PI/sections) );

    // Fixes bug where it would set currentSection = number of sections
    // if on boundry between the final section and section 0
    if (calculatedSection >= sections) calculatedSection = 0;

    if (calculatedSection != currentSection) {
      prevSection = currentSection;
      currentSection = calculatedSection;
    }

    // DEBUGGING CURRENT SECTION
    // System.out.println("angle  : " + posAngle);
    //System.out.println("prev. section: " + prevSection);
    //System.out.println("curr. section: " + currentSection);


    this.centerSize = centerSize;
    pos = new PVector(0, centerSize + PLAYER_CENTER_GAP);

    this.currentWavePattern = currentWavePattern;
    checkCollisions();


    // MOVING LEFT/RIGHT
    if (dir != null) {
      if (dir.toLowerCase() == "left") {
        if (collidingClockwise) collidingClockwise = false;
        posAngle -= playerSpeed;
        if (posAngle < 0) {
          posAngle += TWO_PI;
        }
      } 
      else if (dir.toLowerCase() == "right") {
        if (collidingAnticlockwise) collidingAnticlockwise = false;
        posAngle += playerSpeed;
        if (posAngle > TWO_PI) {
          posAngle -= TWO_PI;
        }
      }
    }

    // SET ANGLES IF COLLIDING WITH SIDE WALLS
    if (collidingAnticlockwise) {
      posAngle = (TWO_PI/sections) * prevSection;
    } 
    else if (collidingClockwise) {
      posAngle = (TWO_PI/sections) * currentSection;
    }
    
  }


  void display() {
    
    pushMatrix();
    
      rotate(posAngle + PI + HALF_PI);
      translate(pos.x, pos.y);
  
      if (isLeft) {
        rotate(-0.3);
      } else if (isRight) {
        rotate(0.3);
      }
  
      fill(playerCol);
      stroke(playerCol);
      triangle(0, 0, -(playerWidth/2), -playerHeight, playerWidth/2, -playerHeight);
  
      //System.out.println("Displaying player at " + pos);
      
    popMatrix();
  }
}
