class Background {

  Center center;
  float angle = 0;
  float rotationSpeed;
  float prevRotationSpeed;
  boolean startingSpin = false;
  boolean doingSpin = false;
  int endingSpin;

  ArrayList<Integer> bgColors;
  

  Background() { 
    rotationSpeed = random(0.02,0.03);
    newBgColors();
    center = new Center();
  }


  // BACKGROUND UPDATE
  void update() {

    if (startingSpin && !doingSpin && frameCount < endingSpin) {
      startingSpin = false;
      doingSpin = true;
      prevRotationSpeed = rotationSpeed;

      if (rotationSpeed < 0)    updateRotationSpeed(0.09);
      else                      updateRotationSpeed(-0.09);
    }

    if (doingSpin && frameCount >= endingSpin) {
      doingSpin = false;
      updateRotationSpeed(prevRotationSpeed);
    }

    // ROTATE BACKGROUND
    angle += rotationSpeed;
    rotate(angle);

  }
  

  void updateRotationSpeed(float speed) {
    rotationSpeed = speed;
  }
  

  void doSpin() {
    startingSpin = true;
    endingSpin = frameCount + 70;
  }
  

  // GENERATE new BG colors based on the # of sections
  void newBgColors() {
    bgColors = new ArrayList<Integer>();
    

    // If the number of sections is EVEN
    if (evenSections) {
      for (int i = 0; i < sections; i ++) {
        if (i % 2 == 0) {
          bgColors.add(color(100, 10, 10));
        } else {
          bgColors.add(color(90, 10, 10));
        }
      }
    }
    // If the number of sections is ODD
    else {
      for (int i = 0; i < sections; i ++) {

        if (i % 3 == 0) {
          bgColors.add(color(90, 10, 10));
        } else if (i % 2 == 0) {
          bgColors.add(color(100, 10, 10));
        } else {
          bgColors.add(color(110, 10, 10));
        }
      }
    }
  }


  void display() { 

    for (int i = sections; i > 0; i--) {
      fill(bgColors.get(i-1));
      arc(0, 0, height*2, height*2, TWO_PI/((float)(sections))*(i-1), TWO_PI/((float)(sections))*i);
    }

    updateCenter();
    
  }
  

  void updateCenter() {

    // INPUTS
    if (isLeft) {
      center.update("left");
    }
    if (isRight) {
      center.update("right");
    } else {
      center.update(null);
    }

    center.display();
  }
  
}
