class Obstacle {

  int section;
  float angle;
  float distFromCenter;
  float thickness;


  Obstacle(int section) {

    this.section = section;

    distFromCenter = width;
    angle = HALF_PI + (TWO_PI/sections/2) + (TWO_PI/sections) * section;
    this.thickness = obThickness;
    
  }


  void update() {
    
    if (distFromCenter > 0) {
      distFromCenter -= obstacleSpeed;
    } else if (thickness > 0) {
      // If obstacle is touching the center, reduce thickness until no longer visible
      thickness -= obstacleSpeed;
    }
    
  }


  // DISPLAY OBSTACLE IN ITS SECTION
  void display() {

    pushMatrix();

      rotate(angle);
  
      float theta = ((TWO_PI/sections)/2.0);
      float innerWidth = tan(theta)*distFromCenter*2;
      float outerWidth = tan(theta)*(distFromCenter+thickness)*2;
  
      fill(200, 0, 0);
      noStroke();
      
      quad(  -(innerWidth/2), -distFromCenter, 
              (innerWidth/2), -distFromCenter, 
              (outerWidth/2), -distFromCenter-thickness, 
              -(outerWidth/2), -distFromCenter-thickness
          );
  
      strokeWeight(7);
      stroke(200, 0, 0);

    popMatrix();
    
  }
  
}
